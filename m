From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: some missing spin_unlocks
Date: Wed, 24 Aug 2005 11:56:58 -0400
Message-ID: <1124899018.3855.5.camel@mindpipe>
References: <430A5127.5000304@coverity.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751082AbVHXP5D@vger.kernel.org>
In-Reply-To: <430A5127.5000304@coverity.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ted Unangst <tedu@coverity.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

[added alsa-devel to cc:]

On Mon, 2005-08-22 at 15:26 -0700, Ted Unangst wrote:
> I think these are all real bugs.
> 
> sound/synth/emux/emux_synth.c snd_emux_note_on, line 101
> snd_assert will return without unlocking emu->voice_lock (line 89)

This one is probably a real bug.

Lee
