From: =?iso-8859-2?Q?St=E9phane_Boulanger?= <stephane.boulanger@fh-bonn-rhein-sieg.de>
Subject: Re: Opening a device 2 times, loopback interface....
Date: Mon, 26 May 2003 17:10:48 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <00ea01c32398$fcffa780$490a140a@pc2m73>
References: <Pine.LNX.4.44.0305131207020.1179-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

Thanks for the response. I had a look at the ALSA plugins. The dsnoop see=
ms
to be the right way, but I can=B4t get it working for my purpose. The
following works already:

.asoundrc contains:

pcm.my_devicename {
    type dsnoop
    ipc_key 47114711
    ipc_key_add_uid yes
    slave {
        pcm "hw:0,0"
    }
}

I can open this with the snd_pcm_open function.
The important thing is, that 2 applications can access the data at the sa=
me
time. When I start my application (just a simple capturing tool)  twice,
both applications receive data. It works preatty well. But when I want to
start my application after I started an other application (in my case RAT=
),
my application blocks. That=B4s exactly I wanted to prevent!
I think the most other applications will open "hw" or "plughw" (what abou=
t
the OSS emulation? How does the kernel oss emulation module opens the als=
a
devices?).
I tried the following hack: renaming the "hw" to "hw_real" an adding a "h=
w"
wich is my dsnoop.
Looks like:

pcm.hw {
    type dsnoop
    ipc_key 47114711
    ipc_key_add_uid yes
    slave {
        pcm "hw_real:0,0"
    }
}


pcm.hw_real {
... # changed nothing
}

Okay, both applications run, but not at the same time. Still the same
problem: My applications receives data only if the first application was
terminated. By the way... playing around this way with "plughw" let my
application crash.
So again the same problem: Access the input (and output (have a look at m=
y
earlier description in my old mail)) data at the same time, without
modifying the original programm.

I hope this is not too basic, but I just can=B4t figure out a universal w=
ay to
do it. Probably someone has an idea or a tip?
Thanks!

Stephane

----- Original Message -----
From: "Jaroslav Kysela" <perex@suse.cz>
To: "St=E9phane Boulanger" <stephane.boulanger@fh-bonn-rhein-sieg.de>
Cc: <alsa-devel@lists.sourceforge.net>
Sent: Tuesday, May 13, 2003 12:11 PM
Subject: Re: [Alsa-devel] Opening a device 2 times, loopback interface....


> On Tue, 13 May 2003, [iso-8859-1] St=E9phane Boulanger wrote:
>
> > Dear List,
> >
> > we=B4re currently developing an end-to-end delay measurement tool, th=
at
should
> > not only measure the network delay, but also the time the application
> > (audiostreaming (rat, for example)) needs to calculate the used
algorithms
> > (GSM, PCM, whatever). To realize the choosen program design, we need =
to
> > access the soundcard device form two different applications (streamin=
g
> > application and the measurement tool) at the same time. More exactly:
> >
> > - When audiodata is inputted, not only the streaming application shou=
ld
be
> > able to access it, but also our measurement tool (at the same time
> > obviously).
> >
> > - When audiodata is send to the sounddriver (repectively the soundcar=
d),
the
> > measurement tool should be able to read it (maybe in the form of a
copied
> > datastream send to the measurement tool).
> >
> >
> > While browing the ALSA documentation, I found some interesting parts
about
> > the loopback interface, that might help us. But is it still contained=
 in
the
> > 0.9 version of ALSA? Moreover, would the loopback interface satisfy o=
ur
> > needs?
>
> The loopback interface is dead. We have alsa-lib which can do all
> requested things. See the dsnoop plugin and file plugin. You may also
> modify them to satisfy your requirements.
>
> The only "negative" item is that it will work with ALSA native
> applications only or with the alsa-oss library.
>
> Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
>
>
>
> -------------------------------------------------------
> Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
> The only event dedicated to issues related to Linux enterprise solution=
s
> www.enterpriselinuxforum.com
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>
>



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
