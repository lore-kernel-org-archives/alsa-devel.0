From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: ALSA Leaking memory
Date: Sun, 25 Nov 2007 23:10:04 +0100
Message-ID: <20071125221004.GA23860@tango.0pointer.de>
References: <20071125214111.GA20742@tango.0pointer.de>
	<Pine.LNX.4.61.0711252254250.7688@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 93B7E24619
	for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2007 23:10:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0711252254250.7688@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 25.11.07 22:56, Jaroslav Kysela (perex@perex.cz) wrote:

> > ==22198== 10 bytes in 1 blocks are definitely lost in loss record 1 of 3
> > ==22198==    at 0x4023765: malloc (vg_replace_malloc.c:149)
> > ==22198==    by 0x417C44F: strdup (strdup.c:43)
> > ==22198==    by 0x4071954: snd_determine_driver (in /usr/lib/libasound.so.2.0.0)
> > ==22198==    by 0x406E80C: snd_config_hook_load_for_all_cards (in /usr/lib/libasound.so.2.0.0)
> > ==22198==    by 0x406EC7C: (within /usr/lib/libasound.so.2.0.0) 
> > ==22198==    by 0x406F896: snd_config_searcha_hooks (in /usr/lib/libasound.so.2.0.0)
> > ==22198==    by 0x406FA74: snd_config_search_alias_hooks (in /usr/lib/libasound.so.2.0.0)
> > ==22198==    by 0x406FCD9: snd_config_search_definition (in /usr/lib/libasound.so.2.0.0)
> > ==22198==    by 0x40952FE: (within /usr/lib/libasound.so.2.0.0)
> > ==22198==    by 0x80484D7: main (in /home/lennart/alsa-test)
> 
> Broken valgrind? 

Unlikely.

> I cannot reproduce here and from first glance, the error 
> path in snd_config_hook_load_for_all_cards is good.

I don't fully grok the code of that function
(snd_config_hook_load_for_all_cards()), but from *my* first glance I see
that snd_determine_driver() allocates the string. Immediately after
that call there are at least two "continue"s which will cause immediate
jumping to the next iteration of the loop this whole code lives in,
without ever freeing the string.

Or am I blind or missed something?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
