From: =?UTF-8?B?U2VyZ2V5?= <sergemp@mail.ru>
Subject: Re:
 =?utf-8?q?ALSA_1=2E0=2E28_release_-_Assertion_failed?=
Date: Sat, 14 Jun 2014 16:11:04 +0400
Message-ID: <1402747864.49543317@f431.i.mail.ru>
References: <1402647348-25604-1-git-send-email-david.henningsson@canonical.com>
 <539AC54C.60504@canonical.com> <539ACD9A.5040209@perex.cz>
Reply-To: =?UTF-8?B?U2VyZ2V5?= <sergemp@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from f431.i.mail.ru (f431.i.mail.ru [185.5.136.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D797262606
 for <alsa-devel@alsa-project.org>; Sat, 14 Jun 2014 14:11:05 +0200 (CEST)
Received: from mail by f431.i.mail.ru with local (envelope-from
 <sergemp@mail.ru>) id 1WvmnY-00059w-Ag
 for alsa-devel@alsa-project.org; Sat, 14 Jun 2014 16:11:04 +0400
In-Reply-To: <539ACD9A.5040209@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?YWxzYS1kZXZlbA==?= <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Fri, 13 Jun 2014, Jaroslav Kysela wrote:

>   ALSA 1.0.28 packages are available for testing at
> 
> ftp://ftp.alsa-project.org/pub/testing/
> 
>   Please, report any issues. I expect to announce the release on Monday.

I get "Assertion failed" with plug for float data.
No patch yet. I'm still trying to understand how "plug" works.
The bug was in earlier alsa versions too. Was almost fixed by 2da7b0c2
(discussion http://thread.gmane.org/gmane.linux.alsa.devel/119358)

I first found it with a complex ladspa upmix config, like:
  http://forums.gentoo.org/viewtopic-p-4528619.html#4528619
An easy way to see the assertion:
pcm.!default {
    type plug
    slave.pcm { type null }
    ttable.0.0 1
}
# aplay -fFLOAT_LE /dev/zero
Playing raw data '/dev/zero' : Float 32 bit Little Endian, Rate 8000 Hz, Mono
aplay: pcm_plug.c:388: snd_pcm_plug_change_channels: Assertion `snd_pcm_format_linear(slv->format)' failed.
Aborted by signal Aborted...

-- 
  Sergey
