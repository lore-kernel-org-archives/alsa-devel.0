From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Error: firmware not found
Date: Tue, 25 Jan 2005 14:57:16 +0100 (CET)
Message-ID: <XFMail.20050125145716.pochini@shiny.it>
References: <m2acqxabo4.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m2acqxabo4.fsf@vador.mandrakesoft.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thierry Vignaud <tvignaud@mandrakesoft.com>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On 25-Jan-2005 Thierry Vignaud wrote:

>> No, it isn't, because those devices use the same PCI card, that is
>> the kernel reports the same PCI ID/subID's. The driver has to load
>> the firmware and then it asks the DSP what (if any) external box is
>> attached. If it is the wrong driver it exits with -ENODEV.
>
>:-(
>
> are these cards rare or not?

Just about other high-end cards I guess. Only the Layla3G and
the Gina3G share the same PCI card. All other Echo cards don't.


> b/c this is a big issue for hw auto configuring (eg as we do in
> mandrakelinux).

I don't know how mkd autoconfig works, but IMHO you just have
to load both *3g modules if their PCI ID is detected. That
change to pci.agent does exactly this.


> would it be possible to create a snd-echoaudio frontend driver that
> would try sub-drivers (gina*, layla*, ...) which would load the
> firmware & ask DSP ?

Probably yes, but I don't know how to do it right now.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
