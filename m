From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Subject: Re: [RFC PATCH] Inverted internal mic
Date: Sat, 23 Jun 2012 14:58:31 +1200
Message-ID: <4FE530D7.90501@blennerhassett.gen.nz>
References: <4F4C9714.1080307@canonical.com> <s5haa43ux7u.wl%tiwai@suse.de>
	<4F4CA438.90103@canonical.com> <s5hvcmrp7ji.wl%tiwai@suse.de>
	<4F4CD1AF.2050409@canonical.com> <s5hboojozx7.wl%tiwai@suse.de>
	<4F4CE264.7040008@canonical.com>
	<loom.20120619T050139-760@post.gmane.org>
	<4FE02D8B.7050201@canonical.com> <s5htxy6f6tt.wl%tiwai@suse.de>
	<4FE275AF.4080004@canonical.com> <s5hhau4esiu.wl%tiwai@suse.de>
	<4FE31BEC.20708@canonical.com> <s5hbokcerax.wl%tiwai@suse.de>
	<4FE32E74.1040902@canonical.com> <s5h62aj4rov.wl%tiwai@suse.de>
	<4FE44D1F.1060903@canonical.com> <s5h1ul7d31x.wl%tiwai@suse.de>
	<s5hsjdnbjka.wl%tiwai@suse.de> <4FE48EF7.6060101@canonical.com>
	<s5ha9zvbbno.wl%tiwai@suse.de> <4FE4AC52.4050600@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id EBB8E103D27
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Jun 2012 04:58:36 +0200 (CEST)
Received: from mxin1-orange.clear.net.nz
	(lb2-srcnat.clear.net.nz [203.97.32.237])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0M6100D8VUXIN300@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Sat, 23 Jun 2012 14:58:32 +1200 (NZST)
In-reply-to: <4FE4AC52.4050600@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 23/06/12 05:33, David Henningsson wrote:
> For users running Ubuntu 12.04 (I think Eliot does), I have also made a
> dkms package for easy testing of these two patches, and I also asked
> existing bug reporters to test it.
> 
> https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1002978/+attachment/3200653/+files/alsa-hda-dkms_0.1_all.deb

Thanks David,

I can confirm that the right channel is muted when "Inverted Internal
Mic" is "off".  and e.g. skype test call works well.

BTW I initially assumed that "on" == "fix inverted internal mic"  rather
than "on" == "Enable Internal Mic Right Channel"
