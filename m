From: DaeRyong Jeong <threeearcat@gmail.com>
Subject: Re: WARNING in port_delete
Date: Tue, 24 Jul 2018 16:14:14 +0900
Message-ID: <3e2c5bd7-daac-4af8-9419-20d775a0b063@Spark>
References: <20180724033608.GA17607@dragonet>
 <CACsK=jdZ5W8AHtjZinwh=9-e5jUo_Lo1mNesvDygdJhPRpPMvw@mail.gmail.com>
 <s5hy3e1xgm0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="5b56d23a_5bd062c2_629"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hy3e1xgm0.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Colin King <colin.king@canonical.com>, perex@perex.cz, alsa-devel@alsa-project.org, Kyungtae Kim <kt0755@gmail.com>, Byoungyoung Lee <lifeasageek@gmail.com>, syzkaller@googlegroups.com, bammanag@purdue.edu, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

--5b56d23a_5bd062c2_629
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I agree with that having a C reproducer would be much better.
Now I'm working on it.
I will immediately let you know once I get the C reproducer.


Thank you.

Best regards,
DaeRyong Jeong
On 24 Jul 2018, 4:00 PM +0900, Takashi Iwai <tiwai@suse.de>, wrote:
> On Tue, 24 Jul 2018 05:59:56 +0200,
> DaeRyong Jeong wrote:
> >
> > I just realized that the crash has been spotted by Syzkaller a few days before.
> > (https://syzkaller.appspot.com/bug?id=3490860a465e6b39227c6906f0ef2d40ad4d5bb1)
> >
> > I'm CC'ing Syzkaller's mailing list.
>
> It's very likely a false-positive sanity check, and if so, nothing
> serious at all. We may simply remove two snd_BUG_ON() lines.
>
> But I'd love to have a C reproducer to confirm my understanding is
> correct...
>
>
> thanks,
>
> Takashi
>
> ---
> --- a/sound/core/seq/seq_ports.c
> +++ b/sound/core/seq/seq_ports.c
> @@ -272,9 +272,6 @@ static int port_delete(struct snd_seq_client *client,
> if (port->private_free)
> port->private_free(port->private_data);
>
> - snd_BUG_ON(port->c_src.count != 0);
> - snd_BUG_ON(port->c_dest.count != 0);
> -
> kfree(port);
> return 0;
> }

--5b56d23a_5bd062c2_629
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>I agree with that having a C reprodu=
cer would be much better.<br />
Now I'm working on it.<br />
I will immediately let you know once I get the C reproducer.<br />
<br />
<br />
Thank you.<br />
<br />
Best regards,<br />
DaeRyong Jeong</div>
<div name=3D=22messageReplySection=22>On 24 Jul 2018, 4:00 PM +0900, Taka=
shi Iwai &lt;tiwai=40suse.de&gt;, wrote:<br />
<blockquote type=3D=22cite=22>On Tue, 24 Jul 2018 05:59:56 +0200,<br />
DaeRyong Jeong wrote:<br />
<blockquote type=3D=22cite=22><br />
I just realized that the crash has been spotted by Syzkaller a few days b=
efore.<br />
(https://syzkaller.appspot.com/bug=3Fid=3D3490860a465e6b39227c6906f0ef2d4=
0ad4d5bb1)<br />
<br />
I'm CC'ing Syzkaller's mailing list.<br /></blockquote>
<br />
It's very likely a false-positive sanity check, and if so, nothing<br />
serious at all. We may simply remove two snd=5FBUG=5FON() lines.<br />
<br />
But I'd love to have a C reproducer to confirm my understanding is<br />
correct...<br />
<br />
<br />
thanks,<br />
<br />
Takashi<br />
<br />
---<br />
--- a/sound/core/seq/seq=5Fports.c<br />
+++ b/sound/core/seq/seq=5Fports.c<br />
=40=40 -272,9 +272,6 =40=40 static int port=5Fdelete(struct snd=5Fseq=5Fc=
lient *client,<br />
if (port-&gt;private=5Ffree)<br />
port-&gt;private=5Ffree(port-&gt;private=5Fdata);<br />
<br />
- snd=5FBUG=5FON(port-&gt;c=5Fsrc.count =21=3D 0);<br />
- snd=5FBUG=5FON(port-&gt;c=5Fdest.count =21=3D 0);<br />
-<br />
kfree(port);<br />
return 0;<br />
=7D<br /></blockquote>
</div>
</body>
</html>

--5b56d23a_5bd062c2_629--
