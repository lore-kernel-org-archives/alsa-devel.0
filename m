From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: matrix mixer control (Re: Complex mixer questio
Date: Mon, 31 Mar 2003 12:18:15 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303311712.TAA23215@alsa.alsa-project.org>
References: <20030331144500.GA20506@ee.unsw.edu.au>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail09.voicenet.com (mail09.voicenet.com [207.103.0.43])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id TAA23215
	for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2003 19:12:31 +0200
In-reply-to: Your message of "Tue, 01 Apr 2003 00:45:00 +1000."
             <20030331144500.GA20506@ee.unsw.edu.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Matt Flax <flatmax@pgb.unsw.edu.au>
Cc: core sound <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>I think this is a great step forward ... it will open the door for 3D 
>array audio applications.
>Typically these applications use 3D speaker arrays which each have 
>individual gains set for each audio 'object'.
>Consequently depending on an audio object's location in 3D space, will 
>depend on the relative speaker gains for that particular audio object.
>
>Consequently each audio object has its own mixer matrix. There is also a 
>master mixer matrix for calibration - this generally occurs when you 
>have external amplifiers which are different or not calibrated.

actually, i think that this has almost nothing to do with 3d array
audio applications, because the code to do that generally runs in user
space.

the question under discussion concerns the control of hardware that
has matrix control elements, of which there are only 2 known at this
time. 

you could do 3d array audio stuff with many consumer cards entirely
within the application code. perhaps i misunderstood your point
entirely. 

--p


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
