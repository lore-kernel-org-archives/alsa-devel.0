From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] sound: aoa: printk replacement
Date: Wed, 10 Sep 2014 15:57:04 +0200
Message-ID: <1410357424.2761.5.camel@jlt4.sipsolutions.net>
References: <1410357107-29933-1-git-send-email-sudipm.mukherjee@gmail.com>
	 (sfid-20140910_155200_822543_7A3FBE01)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410357107-29933-1-git-send-email-sudipm.mukherjee@gmail.com> (sfid-20140910_155200_822543_7A3FBE01)
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2014-09-10 at 19:21 +0530, Sudip Mukherjee wrote:
> as pr_* macros are more preffered over printk, so printk replaced
> with corresponding pr_* macros.

Are you simply running checkpatch on every file and decided to do
something about it? :)

I'll let Takashi decide whether to take this or not as I no longer care
about this code, but IMHO this changes is completely pointless since you
don't also clean up the code to have a common prefix with #define pr_fmt
and then clean up the callers etc.

There's a reason pr_* is preferred, but random code changes like this
aren't it, I think.

johannes
