From: "Prabhu Sivaraja" <prabhu.sivaraja@gmail.com>
Subject: Re: DMix period_size should always be half of buffer
	size?
Date: Fri, 4 May 2007 14:02:33 -0700
Message-ID: <49f264960705041402r17ab4d8anc1ed667ab0553e83@mail.gmail.com>
References: <49f264960705031550q4884453ck6d9d6a1f1b6ef6d@mail.gmail.com>
	<Pine.LNX.4.61.0705040903340.7594@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_42586_20339558.1178312553467"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.231])
	by alsa0.perex.cz (Postfix) with ESMTP id 33E4C244E2
	for <alsa-devel@alsa-project.org>;
	Fri,  4 May 2007 23:02:35 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so965753nzf
	for <alsa-devel@alsa-project.org>; Fri, 04 May 2007 14:02:34 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.61.0705040903340.7594@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_Part_42586_20339558.1178312553467
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for your help Jaroslav. I am attaching the debug files from
/proc/asound/card0/pcm0p/sub0 that I captured while playing a wav file
through aplay. I have attached both instances with 64KB bufsize/32KB
periodsize(works) and 64KB bufsize/4KB periodsize(does NOT work).

Here are the weird things I noticed in the attached debug captures. Maybe it
would make more sense to you.
1. If you take a look at the hw_params file you would see that period and
buffer size reported are 1/4th of what I have declared in the driver. Why is
this? Seems weird.

2. Status file clearly shows the hw_ptr has not moved in the 4KB period
size. I captured these files few secs after starting aplay. hw_ptr never
increments from 0 when period size size is NOT half the buf size. About
calling period_elapsed( ) like you mentioned in your mail, dont you think it
is irrelevant because the hw_ptr never moves to begin with? If it moved for
the first period and then never moved I could see how calling
period_elapsed( ) would matter but in this case where it never moved from
the beginning.

Regards
Prabhu.


On 5/4/07, Jaroslav Kysela <perex@suse.cz> wrote:
>
> On Thu, 3 May 2007, Prabhu Sivaraja wrote:
>
> > This is a followup to my earlier question about dmix not being able to
> mix
> > small files. I investigated it more and here is what I found.
> >
> > Again background info.
> > I have a 64KB as kernel buffer and a 64KB circular buffer for my device.
> In
> > a poll thread I copy the data obtained from ALSA lib from the kernel
> buffer
> > to my device circular buffer by keeping track of appl_ptr and
> hw_ptr(dmix
> > only). Everything was working fine except when I was trying to mix files
> > smaller than 64KB(my buffer size), the small file was not getting mixed
> > through the dmix plugin. Anything over 64KB was getting mixed just fine.
> So
> > I set about reducing my period size from 32KB to 4KB while maintaining
> my
> > buffer size at 64KB.
> >
> > When I tried to do this my hw_ptr never gets incremented from 0. Hence
> my
> > driver is stuck in a loop waiting for bytes to copy. This is only
> observed
> > when I am using dmix plugin and NOT when using hw or plughw. When my
> period
> > size is half the size of my buffer everything works fine with dmix (I
> > verified this by reducing my buffer size to 8KB and making my period
> size
> > 4KB. hw_ptr gets incremented then but I get buffer problems). It seems
> like
> > dmix is forcing me to keep my period size half the size of my buffer. hw
> and
> > plughw devices do not seem to do that.
> >
> > Is this a limitation of dmix. Could anyone comment on the dmix
> limitation
> > that I am experiencing.
>
> No, dmix works with more periods well. Send us debug info from
> /proc/asound/card0/pcm0p (when the stream is opened) and check, if your
> driver notifies higher PCM level with period_elapsed() and if your
> position callback returns right value when the stream is started.
>
>                                                Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SUSE Labs
>

------=_Part_42586_20339558.1178312553467
Content-Type: application/x-bzip2; name=32KBPeriodSize.tar.bz2
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1b4rwa9
Content-Disposition: attachment; filename="32KBPeriodSize.tar.bz2"

QlpoOTFBWSZTWYozr1cAAe9/hP0QAEBIY//4Pq//9P/v3/AAAIAYQAI8AkARNApk9IAaANAAZAA0
aGmgAA4yZNGIYmmAgYE0wRgmJppoAMIcZMmjEMTTAQMCaYIwTE000AGEEkgJpo1Mmk0aaoYmmmTQ
9AA0NEPU2ozaJ9Edp1HO3+7EQIobBmTJA0wQKDI5Nu/fvgjUI5USbfOguK8SZDJJbnDxDDJPoOqM
Ou7702nhfv8Enzs9npmg0P1dGqMEjqQyBjq6/p1x/uniohkhQZAxbYtz/CTchhIYyG/R7uhkM4OV
kJGv9rivP0N0fHNJWGRKrVGQfk+y/loWlNEE4O6iKoPg4ojnu78FksEXZ0Yc/xkVHaxLBEy52P70
MMESirM5DoLBw4gMMqc0gjkFVjzWL5Rck2Bdeh/ZIvjBJmm0EVmoYmalKZinqD05SgeK/ufXpO7z
M1kzh7QmFGNSjguAnQXyK4LFBjQ627BrfO8gIDmBt7gXipl99aA5jFiyIxiOIhpSQRBkIlfVPBpo
R+AUaCKIFpJ9IYIF7gG647xQmfb3PRU/x2Oo0LoE6sQjwSedOr/+C1DGMnN9tRhbBSqUa64ZjS9W
7DJnZvcQMDCNXEtOB2ZlCiaiOmXFXLK/WU5VZcJ7kPdbPjCZE0MZEFfUNbjTaoxLysXSLjjkQHJg
dk1s7jXaPHdDZjEz3KwjSRrEY5zsNDM/MzNmXJEcjAonEmlCyaJQ1o60TMDTabGuRgYppj6k0Q39
s3rNkdmoRyVOPEQ4a5TYdoM8rF6W2hbtREMkcU2fRsNy2pJfcXckU4UJCKM69XA=
------=_Part_42586_20339558.1178312553467
Content-Type: application/x-bzip2; name=4KBPeriodSize.tar.bz2
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1b4sgvl
Content-Disposition: attachment; filename="4KBPeriodSize.tar.bz2"

QlpoOTFBWSZTWW3d0OsAAeb/hP0QAEBIY//wPq//9P/v3/AAAIAYQAI8DMmAagjSaNGgBpoaABoA
GRoaaANNAZIIepkCnqAAAAPUAAAZAPKDhppkYjCaYCGATTCMExMhpkaGgEihGiYUemlPGpqA0DRi
AB6jIBkGT1OhG46Ta/zoRIoQ7W00gcwQKTQ8tfBr4EbwiKIktkxaKxJoaSWuBEQxpRrUBtnDBPP4
o8Hg7cZ3NwTcnHwwhmRYkdKGgZ09XR1UfaupHECUmgZdisqYuSGkho78Ic7Q4GTMhoSMNnEV7efn
hzYJLjaKQqcWBm7tt28uTlgE55kRUAjUhkVNG3uZ0S4zErbLkOMOTNGqCKrFYoIcqxgiK8hHgPiA
2UQupElkGwInRxDmKQpwhK0lFIeZaij3hC0uY0UUCC6d2994hrcaJtNucHjbY6MzZkCsN7KqFDDW
7jdgcfSeTECRw29yNzYWoPvqwJHOZdRc5G046EEKUURJuuMBpopYgYrLKDGqohTWIMMQDEYWwqFB
C6cgkDEyioWiZwlggc+8lox1fV5qCCiRiflQjTEyQCpNMEQWzmnA1ssYwOERF8GCS28YWBQpRSMc
mVCuufIC55vXXPJEYX4agmUGJdSSWawM8DHSqKDMWUQpKjVSSIJhDfd+FRnvo1VS0XUGGSvEY0mc
RdhO8csDhMDRv66CCLStQKXTK9OgrM6OtEy0x0mh1ItLk5kbCaJbN04rBo5d4RrsNVwiA6lNkMRx
LKIpaay/cigN9HYm41u3JaUkv+LuSKcKEg27uh1g
------=_Part_42586_20339558.1178312553467
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_42586_20339558.1178312553467--
