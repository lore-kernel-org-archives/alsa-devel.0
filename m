From: Mark Knecht <markknecht@gmail.com>
Subject: Re: Maintaining sound card at a specific frequency
Date: Wed, 19 Jan 2005 11:59:56 -0800
Message-ID: <5bdc1c8b05011911596ebc3144@mail.gmail.com>
References: <5bdc1c8b050116130511757cbf@mail.gmail.com>
	 <1105938846.41eb499ec3527@www3.webhosting.cx>
Reply-To: Mark Knecht <markknecht@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1105938846.41eb499ec3527@www3.webhosting.cx>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Jan 2005 06:14:06 +0100, Patrick Shirkey
<pshirkey@boosthardware.com> wrote:
> Quoting Mark Knecht <markknecht@gmail.com>:
> 
> >
> > I guess I'm wondering if there isn't some .asoundrc magic that could
> > be done in my Linux account on this machine that would tell all
> > applications (other than Jack for now) to use some virtual device that
> > handles all frequencies. If that virtual device was the default and
> > the resampling (for Mozilla/games/whatever) was done in software and
> > the sound cards frequency was never changed then I think things would
> > work much better.
> >
> 
> I think you can use default as the device name in .asoundrc and it will be used
> as the default device for all apps.
> 
> Then just give it a plughw instead of hw
> 
> ex.
> 
> pcm.default {
>         type plughw
>         card card1
>         device 0
> }
> 
> ctl.default {
>         type hw
>         card 0
> }
> 

Patrick,
   This was interesting. With this file in place the card was locked
into 48KHz and the controls in hdspconfig wouldn't change it. I wonder
why? Did this allow Alsa to lock up the card so that even hdspconf
couldn't get to it? If so that's going a bit too far I think.

   As soon as I removed the file hdspconf worked again...

   Thansk for the ideas. I think they may be part of the solution eventually.

- Mark


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
