From: Matt Whitlock <matt@whitlock.name>
Subject: Re: How to set idle S/PDIF sample rate?
Date: Fri, 29 Feb 2008 03:33:04 -0500
Message-ID: <200802290333.04457.matt@whitlock.name>
References: <mailman.2237.1204248430.2095.alsa-devel@alsa-project.org>
	<00c701c87a98$b7cf6860$d450a8c0@PDSMain2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by alsa0.perex.cz (Postfix) with ESMTP id E01E224535
	for <alsa-devel@alsa-project.org>; Fri, 29 Feb 2008 09:33:07 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c36so837630ana.80
	for <alsa-devel@alsa-project.org>; Fri, 29 Feb 2008 00:33:06 -0800 (PST)
In-Reply-To: <00c701c87a98$b7cf6860$d450a8c0@PDSMain2>
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
To: alsa-devel@alsa-project.org
Cc: Demian Martin <demianm@attglobal.net>, 'Kirill Belokurov' <kirill.b@plutohome.com>
List-Id: alsa-devel@alsa-project.org

On Friday, 29 February 2008 1:02:50 am Demian Martin wrote:
> I noticed another big problem in my application relating to locking the
> system at 48 KHz in the background. If I set SPDIF to 44.1KHz on some
> playback software (Xine for example) between tracks the system briefly
> switches back to 48 KHz. This causes an audible pop as the external DAC
> tries to keep up with the rate change. I have not found a way to lock the
> system at a different rate (44100 for example) so this doesn't happen
> between tracks. This behavior is common to both the ICE1724 and the VT1708
> drivers. 
>        -Demian

I have the same problem between tracks in my audio player of choice (Amarok), though fortunately my receiver doesn't pop when it resynchronizes with the new rate, but it does tend to drop the first second or so of each track because of the rate change.  Sometimes I get lucky and there isn't enough of a pause between tracks for the receiver to come unlocked from 44100 Hz, but more often than not, it does, and therefore loses the first second of the next track.
