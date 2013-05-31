From: =?utf-8?B?0JjQstCw0L0g0JHQvtC70YzRgdGD0L3QvtCy?= <bolsunov@telum.ru>
Subject: dsnoop memory leak
Date: Fri, 31 May 2013 17:58:17 +0400 (MSK)
Message-ID: <103845287.94506.1370008697164.JavaMail.root@telum.ru>
References: <732607619.94502.1370008560183.JavaMail.root@telum.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.telum.ru (mail.telum.ru [62.141.76.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 873A02654BF
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 15:58:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.telum.ru (Postfix) with ESMTP id AF58A4810EF
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 17:58:22 +0400 (MSK)
Received: from mail.telum.ru ([127.0.0.1])
 by localhost (mail.telum.ru [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id DDTldkbQVN_f for <alsa-devel@alsa-project.org>;
 Fri, 31 May 2013 17:58:17 +0400 (MSK)
Received: from mail.telum.ru (mail.telum.ru [127.0.1.1])
 by mail.telum.ru (Postfix) with ESMTP id 4BDAE480183
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 17:58:17 +0400 (MSK)
In-Reply-To: <732607619.94502.1370008560183.JavaMail.root@telum.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Since alsa bug tracker does not work for me for weeks, I have to report bug here. Sorry if it a wrong place.

So, to reproduce memory leak (Alsa lib used v.1.0.27), you have to use next asound.conf:

pcm_slave.myslave
{
    pcm                 "hw:0,0"
}

pcm.mysnoop
{
    type                dsnoop
    ipc_key             1024
    slave               myslave
}

Then you simply do:

snd_pcm_open(&pcm_handle, "mysnoop", SND_PCM_STREAM_CAPTURE, SND_PCM_NONBLOCK);
snd_pcm_close(pcm_handle);
snd_config_update_free_global();

Valgrind will show something like this:

==7889== 
==7889== HEAP SUMMARY:
==7889==     in use at exit: 15,854 bytes in 871 blocks
==7889==   total heap usage: 333,212 allocs, 332,341 frees, 11,695,490 bytes allocated
==7889== 
==7889== 15,834 (6,264 direct, 9,570 indirect) bytes in 174 blocks are definitely lost in loss record 6 of 6
==7889==    at 0x4027CBF: calloc (vg_replace_malloc.c:566)
==7889==    by 0x406B416: _snd_config_make (in /usr/lib/libasound.so.2.0.0)
==7889==    by 0x406C69C: snd_config_make (in /usr/lib/libasound.so.2.0.0)
==7889==    by 0x406C861: snd_config_make_compound (in /usr/lib/libasound.so.2.0.0)
==7889==    by 0x406D00C: _snd_config_copy (in /usr/lib/libasound.so.2.0.0)
==7889==    by 0x406F112: snd_config_walk (in /usr/lib/libasound.so.2.0.0)
==7889==    by 0x406FE04: snd_config_copy (in /usr/lib/libasound.so.2.0.0)
==7889==    by 0x4070370: snd_config_expand (in /usr/lib/libasound.so.2.0.0)
==7889==    by 0x407107E: snd_config_search_definition (in /usr/lib/libasound.so.2.0.0)
==7889==    by 0x40D2C22: _snd_pcm_direct_get_slave_ipc_offset (in /usr/lib/libasound.so.2.0.0)
==7889==    by 0x40D68A2: snd1_pcm_direct_parse_open_conf (in /usr/lib/libasound.so.2.0.0)
==7889==    by 0x40D28CA: _snd_pcm_dsnoop_open (in /usr/lib/libasound.so.2.0.0)
==7889==    by 0x40909C4: snd_pcm_open_conf (in /usr/lib/libasound.so.2.0.0)
==7889==    by 0x4091036: snd_pcm_open_noupdate (in /usr/lib/libasound.so.2.0.0)
==7889==    by 0x804873D: main (in /home/blah/al/a.out)
==7889== 
==7889== LEAK SUMMARY:
==7889==    definitely lost: 6,264 bytes in 174 blocks
==7889==    indirectly lost: 9,570 bytes in 696 blocks
==7889==      possibly lost: 0 bytes in 0 blocks
==7889==    still reachable: 20 bytes in 1 blocks
==7889==         suppressed: 0 bytes in 0 blocks
==7889== Reachable blocks (those to which a pointer was found) are not shown.
==7889== To see them, rerun with: --leak-check=full --show-reachable=yes
==7889== 
==7889== For counts of detected and suppressed errors, rerun with: -v
==7889== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 0 from 0)
