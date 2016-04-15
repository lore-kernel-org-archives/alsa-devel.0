From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: SPDIF trouble with multiple usb devices
Date: Fri, 15 Apr 2016 21:38:30 +0100
Message-ID: <201604152138.30683.gineera@aspect135.co.uk>
References: <570D7676.1060004@ponzo.net>
 <alpine.DEB.2.02.1604131128080.9999@lnxricardw1.se.axis.com>
 <57103D9F.9080803@ponzo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-1.talktalk.net (smtp-out-1.talktalk.net [62.24.135.65])
 by alsa0.perex.cz (Postfix) with ESMTP id B06E42608B3
 for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2016 22:37:01 +0200 (CEST)
In-Reply-To: <57103D9F.9080803@ponzo.net>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Scott Doty <scott@ponzo.net>
List-Id: alsa-devel@alsa-project.org

I can't be any help with the core issue, but...

On Friday 15 April 2016 02:02, Scott Doty wrote:
<snip>
> ....  Also using
> ALSA devices from Audacity (which is what I started with in the first
> place.)

<snip>
> So at least I can investigate that, and read up on using dsnoop and
> plughw devices with Audacity.

The Portaudio code, which is used for audio in Audacity, has an SVN branch 
'alsa_expt_devt' where I began working on a more extensive device listing 
scheme.  That can be checked out into the lib-src of the Audacity code and 
rebuilt for a interesting alternative!  Join us on the Portaudio list to 
discuss it.

Regards

Alan
