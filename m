From: Matej Laitl <strohel@gmail.com>
Subject: Re: [ALSA] HDA: no sound in headphone-out caused by commit f889fa91ad47e (2.6.25-rc1 regression)
Date: Wed, 13 Feb 2008 13:05:48 +0100
Message-ID: <200802131305.48471.strohel@gmail.com>
References: <200802112158.41989.strohel@gmail.com> <200802122357.46309.strohel@gmail.com> <s5hejbht93l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758456AbYBMMGN@vger.kernel.org>
In-Reply-To: <s5hejbht93l.wl%tiwai@suse.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wednesday 13 of February 2008 11:59:58 Takashi Iwai wrote:
> > Now I just found that the new "Speaker" switch forgets it's value from
> > time to time, ie. it's muted, you go and have lunch, and when you get
> > back and start the music, it's unmuted. It is probably related to
> > aggressive hda-codec powersaving, which I have enabled and set to 20
> > secs.
>
> Hm, does the patch below have any influence?
> If the problem still persists, please take alsa-info.sh snapshots
> before and after power-saving.

This patch did not have any effect. (i haven't tested suspend-to-ram)

alsa-info before powersaving (speaker silent, mixer says: Speaker=MM):
http://pastebin.ca/902330

alsa-info after powersaving (speaker loud, mixer says: Speaker=MM):
http://pastebin.ca/902332
