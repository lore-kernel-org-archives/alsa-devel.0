From: Matt Whitlock <matt@whitlock.name>
Subject: Re: How to set idle S/PDIF sample rate?
Date: Tue, 26 Feb 2008 17:25:35 -0500
Message-ID: <200802261725.35575.matt@whitlock.name>
References: <200802222234.22975.matt@whitlock.name>
	<200802251403.21651.matt@whitlock.name>
	<s5hskzfu89e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.247])
	by alsa0.perex.cz (Postfix) with ESMTP id 203872433D
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 23:25:38 +0100 (CET)
Received: by hs-out-0708.google.com with SMTP id l65so3898694hsc.0
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 14:25:37 -0800 (PST)
In-Reply-To: <s5hskzfu89e.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tuesday, 26 February 2008 9:01:17 am Takashi Iwai wrote:
> There is a clear difference between "default" and "spdif" PCMs.
> The default uses dmix plugin with the fixed 48kHz rate.  The spdif is
> a direct access and can use all rates the codec chip supports (but no
> soft-mixing).

Well yes, I knew that.  I was trying to show you the inconsistencies of state in ALSA's handling of the S/PDIF output under various sequences of actions.

Can I assume at this point that there is no way to set the idle S/PDIF output sample rate to 44100 Hz?  That is my original question.
