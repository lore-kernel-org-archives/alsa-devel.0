From: "Matthew R. Hurne" <matt.hurne@versatile.com>
Subject: Re: no front speaker sound with ALC262
Date: Fri, 22 Feb 2008 21:28:15 -0500
Message-ID: <47BF84BF.702@versatile.com>
References: <165af2360802221645p9fa6bb0y3a5573caa7bcdbd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mustang.versatile.com (mustang.versatile.com [206.61.179.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 26D9A103812
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 03:28:16 +0100 (CET)
In-Reply-To: <165af2360802221645p9fa6bb0y3a5573caa7bcdbd7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Dohmen <acidjunk@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rene Dohmen wrote:
> Dear List,
> 
> I have a problem with an Intel HDA soundcard
> lspci output:
> -----
> 00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition
> Audio Controller (rev 01)
> 
> The sound volume is very very low when i use the headphone output. The
> device has integrated speakers but i don't hear any sound coming out of them
> (maybe because the volume is so low...). I've put all the mixer channels to
> the maximum values. When booted in Win XP the soundcard works correctly.
> 
> Is see one line in my logs that indicate that something is wrong: hda_codec:
> Unknown model for ALC262, trying auto-probe from BIOS...
> 
> I didn't have it working with other versions of ALSA.  Tested with
> 1.0.14(provided with ubunty gutsy), then started reading, lots of
> suggestions
> stated that the problem would be solved in 1.0.15, so i compiled 1.0.16 from
> src and replaced the default alsa modules with the new ones.
> 
> De device i 'm using is supplied by tangent (
> http://www.tangent.com/t_all_in_one_LCDPC/vita_8000s.htm) its an all in one
> solution with touchscreen and speakers integrated in one small cabinet.
> 
> I runned the alsa-info.sh script output and uploaded it:
> http://pastebin.ca/913865
> 
> I don't know if this is the correct place for getting help but all help is
> appreciated,

I have the exact same issue, Rene.  So far not much progress has been made - unfortunately I'm an ALSA user, not an ALSA developer.  I did create a bug here:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3725 (that's bug ID 0003725)

I suspect the issue boils down to the driver not recognizing the way things are "wired" together.  See the bug report for more details about what I've done thus far, which is essentially collection of as much information as possible for the ALSA developers to use in troubleshooting the issue.

Regards,
Matt Hurne
