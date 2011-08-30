From: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: Lockdep splat in sound core
Date: Tue, 30 Aug 2011 19:37:55 +0200
Message-ID: <201108301937.55995.maciej.rutecki@gmail.com>
References: <20110822232203.GA15492@amos.fritz.box>
Reply-To: maciej.rutecki@gmail.com
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110822232203.GA15492@amos.fritz.box>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Bombe <aeb@debian.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On wtorek, 23 sierpnia 2011 o 01:22:04 Andreas Bombe wrote:
> The following lockdep splat occurs when the EMU10K1 driver is loaded. It
> actually did that for a long time already, it's about time I finally
> report it:
> 
> =============================================
> [ INFO: possible recursive locking detected ]
> 3.1.0-rc2-00171-gbed8cad #88
> ---------------------------------------------

[...]

I created a Bugzilla entry at 
https://bugzilla.kernel.org/show_bug.cgi?id=42072
for your bug report, please add your address to the CC list in there, thanks!

-- 
Maciej Rutecki
http://www.maciek.unixy.pl
