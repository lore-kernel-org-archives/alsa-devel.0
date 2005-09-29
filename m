From: Matt Porter <mporter@embeddedalley.com>
Subject: Re: hda-intel module hanging if ACPI enabled
Date: Thu, 29 Sep 2005 11:55:17 -0700
Message-ID: <20050929115517.C8457@cox.net>
References: <433C261D.8090100@zymeta.com> <20050929105612.A8457@cox.net> <433C2EDD.4050005@zymeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <433C2EDD.4050005@zymeta.com>; from downey@zymeta.com on Thu, Sep 29, 2005 at 12:13:49PM -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Michael Downey <downey@zymeta.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 29, 2005 at 12:13:49PM -0600, Michael Downey wrote:
> Matt Porter wrote:
> >I am working on some updates to the SigmaTel HDA patch to support these
> >motherboards. The basic issue is that the BIOS doesn't set up the
> >proper configuration default registers on these motherboards so we
> >need to detect the motherboard and load the proper configuration
> >defaults. I also added in some switches to retask those jacks.
> >
> >I have an issue with my boards in that they don't properly reflect
> >the Subsystem ID that should be used for identifying the motherboard
> >and jack configuration.  Can you do a
> >'grep Subsystem /proc/asound/card0/codec#2' and post the results?
> >I'd like to verify that your board shows the proper ID.
> >
> Thanks for the quick reply. Here's my output:
> Subsystem Id: 0x0

Ugh, this is supposed to have a unique identifying value. Did
you get a very early board from Intel?

> The board has a BIOS revision string of: 
> NT9410J.86A.1348.2005.0609.1737. I see that there is a newer BIOS 2104 
> released on Sept. 2 so updating the BIOS might make a difference. I will 
> probably try the update in a day or two so I'll post my results then.

You can check. However, I've looked at the BIOS updates that appear
to have no changes related to the HDA config default regs. My
current patches load up the appropriate config default values but
I currently have an issue with reliably identifying the appropriate
board for each set of values.

You'll also need the patch update to get the retasking controls.
 
I'm working with SigmaTel on this so let me check on some things
regarding board ID and then I'll hopefully have a patch to post
that will work for you.  We may have to resort to manually
specifying the model type for these boards...I'm hoping to
avoid that though.

-Matt


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
