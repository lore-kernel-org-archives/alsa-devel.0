From: David Olofson <david@olofson.net>
Subject: Re: C++ driver ?
Date: Sat, 1 Mar 2003 23:36:34 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303012336.34549.david@olofson.net>
References: <s5hof50zmhx.wl@alsa2.suse.de> <s5hof4wihea.wl@alsa2.suse.de> <1046529108.13656.23.camel@Jay>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1046529108.13656.23.camel@Jay>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Saturday 01 March 2003 15.31, Giuliano Pochini wrote:
> Is there any chance to write a driver in C++ ?  I'll get an
> Echoaudio card soon, so I started to study the "Writing an ALSA
> driver" tutorial by T.Iwai and the C++ sources of the generic
> driver by Echoaudio. That drivers do not use exceptions (VVindos
> don't like it), but things as simple as a "new" do not work in
> kernel context. Did someone write a C++ support library or I have
> to convert everything to C ? Suggestions are welcome...

I've done some C++ in kernel space (RTLinux), but the short story: I=20
wouldn't recommend it, and I don't think anything complex enough to=20
really warrant the use of C++ should live in kernel space anyway.

Either way, I've been looking at that driver too, and intend to turn=20
it into an ALSA driver, one way or another. There will be no C++;=20
I'll either convert the code, or write a new driver.

I only have a Layla20, so I'm not sure what to do with the rest. Seems=20
like the code for all of the cards is very similar, but I'll have to=20
look harder to be sure, since each driver is a separate subclass,=20
with lots of code that appears to be pretty much copy/pasted.


Of course, I don't know how much longer Real Life and other projects=20
will keep me from getting started with this. I just won't start yet=20
another project with a bunch of others in a state of "to be released=20
RSN". Too much task switching overhead. ;-)

If someone beats me to it, I'll do what I can to help out.


//David Olofson - Programmer, Composer, Open Source Advocate

=2E- The Return of Audiality! --------------------------------.
| Free/Open Source Audio Engine for use in Games or Studio. |
| RT and off-line synth. Scripting. Sample accurate timing. |
`-----------------------------------> http://audiality.org -'
   --- http://olofson.net --- http://www.reologica.se ---



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
