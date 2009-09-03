From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Is there a way to figure out if the clocks of two
	snd_pcm_t's	deviate? (snd_pcm_info_get_sync?)
Date: Fri, 4 Sep 2009 01:03:51 +0200
Message-ID: <20090903230351.GA7493@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 482541038C4
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Sep 2009 01:04:16 +0200 (CEST)
Content-Disposition: inline
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

Heya!

I am looking for a way to find out whether the clocks of two
snd_pcm_t's are perfectly in sync and don't deviate (or only deviate
by a constant phase). 

i.e. for real duplex devices that use the same crystal for input and
output this should tell me "Yes" for the playback snd_pcm_t tested
against the recording snd_pcm_t; and for all other, unrelated audio
devices it should return "No".

I found snd_pcm_info_get_sync() in the docs, but its documentation is
a bit terse, so I am wondering if this might be what I want. Is it?

Does this (untested) code snippet do what I hope it does?

<snip>
  snd_pcm_info(a, info_a);
  snd_pcm_info(b, info_b);
  in_sync = memcmp(&snd_pcm_info_get_sync(info_a), &snd_pcm_info_get_sync(info_b)) == 0;
</snip>

Thanks,

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
