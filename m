From: "Russ Pridemore" <russ@pridemore.org>
Subject: Re: Maintaining sound card at a specific frequency
Date: Wed, 19 Jan 2005 16:09:35 -0500 (EST)
Message-ID: <40659.67.97.216.252.1106168975.squirrel@67.97.216.252>
References: <5bdc1c8b050116130511757cbf@mail.gmail.com>
    <Pine.HPX.4.33n.0501191004500.7621-100000@studcom.urz.uni-halle.de>
    <5bdc1c8b050119114935d0795b@mail.gmail.com>
Reply-To: russ@pridemore.org
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <5bdc1c8b050119114935d0795b@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I think I understand your issue, but I'm not sure I like your solution.
Personally, I don't want the sound frequency adjusted in software or by a
cheap soundcard.  This transformation introduces noise and/or distortions
into the sound.  I'm using ALSA to drive a home-theater PC (PVR) setup an=
d
want the purest sound output I can get from a PC to my stereo receiver.  =
I
wish I had an alternative solution to suggest.  Please correct me if I've
been misled here...

Russ

> On Wed, 19 Jan 2005 10:07:18 +0100 (MET), Clemens Ladisch
> <clemens@ladisch.de> wrote:
>> Mark Knecht wrote:
>> > However if I open Mozilla and browse around the Pro Tools side start=
s
>> > telling me that the ADAT clock is invalid. My suspicion is that the
>> > web page I went to in Mozilla has some sort of audio content on it a=
nd
>> > it's not encoded at the frequency I'm running at so Mozilla tries to
>> > change the frequency of the card to adjust.
>>
>> If you don't care about sound in Mozilla(/Flash), you could load the
>> snd-dummy driver and redirect the /dev/dsp symlink to that 'card'
>> ("ln -sf /dev/dsp1 /dev/dsp", assuming the card number is 1).
>>
>> HTH
>> Clemens
>>
>>
> Clemens,
>    Hi. No, on the contrary, I do care about Mozilla having audio
> access. From this thread I think the set of features people like me
> would be looking for would be something like this:
>
> 1) When Alsa is started the sound card comes up running in a known
> frequency. Solved with an amixer command in rc.local or some other
> config file.
>
> 2) When Alsa is started the sound card comes up with a default set of
> mixer values. Not sure how to solve this yet for the HDSP 9652 but I
> presume another set of amixer commands may do this also.
>
> 3) When browsing the web, playing games or doing some other set of
> "normal everyday user" functions, audio commands from the application
> will not change the frequency of the card. I presume that this *might*
> be accomplished with some new default device in my .asoundrc file and
> using the plughw macro and software resampling, along with some
> capability like Takashi's modification to lock the sample rate.
>
> 4) When a special audio control app like qjackctl initializes Jack
> then Jack can change the sample rate of the card. This allows me to
> have the Linux box as the main sample rate controller over the network
> when it needs to be.
>
>    I think the above set of ideas would be pretty much what I'm
> looking for, but that still needs to be discussed a bit before anyone
> starts making major changes.
>
> Thanks!
>
> - Mark
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
