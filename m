From: Matt Flax <flatmax@ieee.org>
Subject: Re: matrix mixer control (Re: Complex mixer questio
Date: Tue, 1 Apr 2003 00:45:00 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030331144500.GA20506@ee.unsw.edu.au>
References: <Pine.LNX.4.44.0303311307170.1602-100000@pnote.perex-int.cz> <XFMail.20030331150304.pochini@shiny.it>
Reply-To: Matt Flax <flatmax@pgb.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp3.unsw.edu.au (smtp3.unsw.EDU.AU [149.171.96.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA20170
	for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2003 15:57:10 +0200
Received: from smtp.unsw.edu.au (antivirus-02.services.comms.unsw.EDU.AU [149.171.193.81])
	by smtp3.unsw.edu.au (8.11.2/8.11.2) with ESMTP id h2VDuwJ14727
	for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2003 23:56:58 +1000 (EST)
Received: from maillationax ([149.171.37.167])
	by smtp.unsw.edu.au (8.11.2/8.11.2) with ESMTP id h2VDuv014721
	for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2003 23:56:58 +1000 (EST)
Received: from flatmax by maillationax with local (Exim 3.36 #1 (Debian))
	id 1900Wy-0005L9-00
	for <alsa-devel@alsa-project.org>; Tue, 01 Apr 2003 00:45:00 +1000
Content-Disposition: inline
In-Reply-To: <XFMail.20030331150304.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: core sound <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I think this is a great step forward ... it will open the door for 3D 
array audio applications.
Typically these applications use 3D speaker arrays which each have 
individual gains set for each audio 'object'.
Consequently depending on an audio object's location in 3D space, will 
depend on the relative speaker gains for that particular audio object.

Consequently each audio object has its own mixer matrix. There is also a 
master mixer matrix for calibration - this generally occurs when you 
have external amplifiers which are different or not calibrated.

Matt

On Mon, Mar 31, 2003 at 03:03:04PM +0200, Giuliano Pochini wrote:
> 
> On 31-Mar-2003 Jaroslav Kysela wrote:
> >> the case 2 is, IMO, the most straightforward way.  the info field will
> >> have number of rows and columns, in addition to min, max and step
> >> values.  the change in the alsa core wouldn't be too much.
> > 
> > I think that we simply touch the barrier given by 'struct
> > sndrv_ctl_elem_id'. The identification which differentiate identical
> > controls is only the 'index' value. If we don't use 'struct
> > sndrv_ctl_elem_id' as the identification unit for read/writing of data,
> > then we end with trouble with notification and other representation
> > (single data unit locking, inactive flag etc). Imagine three or four
> > dimensional data types. [...]
> 
> .count is an uint32. Ok, suppose we do not change it. Then the low
> level driver has to tell user space apps that the index number
> addresses elements in a W*H matrix, so the apps will locate the
> cell at (x,y) by a simple index=x+W*y.
> 
> 
> Bye.
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: ValueWeb: 
> Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
> No other company gives more support or power for your dedicated server
> http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
http://mffm.darktech.org

WSOLA TimeScale Audio Mod  : http://mffmtimescale.sourceforge.net/
FFTw C++                   : http://mffmfftwrapper.sourceforge.net/
Vector Bass                : http://mffmvectorbass.sourceforge.net/
Multimedia Time Code       : http://mffmtimecode.sourceforge.net/


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
