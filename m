From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] alsa: hide HDMI/ELD printks unless in debug kernels
Date: Mon, 09 Apr 2012 09:12:44 -0600
Message-ID: <4F82FC6C.1090501@wwwdotorg.org>
References: <20120409021517.GA14618@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120409021517.GA14618@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Nick Bowler <nbowler@elliptictech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Keith Packard <keithp@keithp.com>
List-Id: alsa-devel@alsa-project.org

On 04/08/2012 08:15 PM, Fengguang Wu wrote:
> These trivial messages will show up repeatedly on hot plug as well as
> video mode changes, which could be annoying.
> 
> Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>

Those messages are very useful for end-users to diagnose problems with
HDMI audio. Is there a way to make the messages dynamic, so users can
get them if they want, without recompiling their kernel?
