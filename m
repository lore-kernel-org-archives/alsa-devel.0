From: Mark Knecht <markknecht@gmail.com>
Subject: Re: Maintaining sound card at a specific frequency
Date: Wed, 19 Jan 2005 15:08:58 -0800
Message-ID: <5bdc1c8b05011915085ae85500@mail.gmail.com>
References: <5bdc1c8b050116130511757cbf@mail.gmail.com>
	 <Pine.HPX.4.33n.0501191004500.7621-100000@studcom.urz.uni-halle.de>
	 <5bdc1c8b050119114935d0795b@mail.gmail.com>
	 <40659.67.97.216.252.1106168975.squirrel@67.97.216.252>
Reply-To: Mark Knecht <markknecht@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40659.67.97.216.252.1106168975.squirrel@67.97.216.252>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: russ@pridemore.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 19 Jan 2005 16:09:35 -0500 (EST), Russ Pridemore
<russ@pridemore.org> wrote:
> I think I understand your issue, but I'm not sure I like your solution.
> Personally, I don't want the sound frequency adjusted in software or by a
> cheap soundcard.  This transformation introduces noise and/or distortions
> into the sound.  I'm using ALSA to drive a home-theater PC (PVR) setup and
> want the purest sound output I can get from a PC to my stereo receiver.  I
> wish I had an alternative solution to suggest.  Please correct me if I've
> been misled here...
> 
> Russ


Yeah, I think you're off target. #1 issue is that by default Alsa
works whatever way it works today. Nothing changes. That way in a
SINGLE PC environment, where you want the best sound quality, the card
changes frequency just like it does today. Nothing changes and you
still get the best operation for what your usage model is.

My suggestion is for a different usage model and most specifically
where you have multiple PCs talking to each other. (I.e. - recording
studio, project studio, composer) In this model we can use multiple
PCs and not have frequencies bouncing around just becasue a single
application ononly one PC decides it wants to operate at a different
frequency. In this case I envision that you enable an OPTION and then
the system acts I said earlier.

Hope that helps,
Mark


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
