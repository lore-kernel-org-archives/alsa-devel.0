From: Mohammad Bahathir Hashim <bahathir@gmail.com>
Subject: Re: ALSA Multichannel through HDMI
Date: Thu, 25 Nov 2010 03:59:52 +0000 (UTC)
Message-ID: <ickmvo$kkf$1@dough.gmane.org>
References: <20100112045102.GA29735@localhost>
	<eb9000ab1001112311o4bcf98dp2b616d1afffec9e0@mail.gmail.com>
	<20100112132140.GA7647@localhost>
	<eb9000ab1001120828l6829c6b1g30916b872a0467f7@mail.gmail.com>
	<20100113010942.GA6435@localhost>
	<eb9000ab1001121732y4212e6m9596f68e24d6c226@mail.gmail.com>
	<20100113014550.GA10184@localhost>
	<eb9000ab1001122048s1ac0d9c3n130692ba83dd53d1@mail.gmail.com>
	<20100113045238.GB26275@localhost>
	<eb9000ab1001122055s54bc6697t6103def1e8ae64ae@mail.gmail.com>
	<20100113050254.GA28475@localhost>
	<AANLkTim8zHRTc0F2CcfoXtxDkH2kpYajCuheo7GoQ4zW@mail.gmail.com>
Reply-To: Mohammad Bahathir Hashim <bahathir@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id B117C103B57
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 05:00:06 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PLT09-0004RY-52
	for alsa-devel@alsa-project.org; Thu, 25 Nov 2010 05:00:05 +0100
Received: from 203.106.17.237 ([203.106.17.237])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 05:00:05 +0100
Received: from bahathir by 203.106.17.237 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 05:00:05 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2010-11-24, John Ettedgui <john.ettedgui@gmail.com> wrote:
> On Tue, Jan 12, 2010 at 9:02 PM, Wu Fengguang <fengguang.wu@intel.com> wrote:
> I am sorry to resurrect this thread after so long, but I still have
> not been able to get anywhere.
> Also it just came to my attention that if my receiver always sees the
> hdmi connection as stereo (apart from when using ac3/dts passthrough)
> channel remapping is not the solution, but somehow something else is
> messed up.
>
> I think I should try some options in modprobe.conf for snd-hda-intel
> but I am not sure which ones, and from all the examples I can find on
> the web, it seems none of them are talking about a radeon hdmi
> connection...
>
> So I'm asking for advice here again :)
>
> Thanks!
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel



Hi, I think there are developments in ffmpeg projects, to support
multichannel passthrough through HDMI, ALSO only provides infra and
interface to the HDMI. The passthrough decoding is handled by apps. 


Here is the snippet from the ffmpeg's 'svn log'
------------------------------------------------------------------------
r25760 | cehoyos | 2010-11-17 20:22:59 +0800 (Wed, 17 Nov 2010) | 6 lines

Add support for IEC 61937 ("SPDIF") encapsulation for E-AC-3.
Only works via HDMI.

Patch by Anssi Hannula (anssi d hannula a iki d fi), based on some work
by myself.
------------------------------------------------------------------------

You can search in ffmpeg's development's mailing list for more information.

Thank you.
