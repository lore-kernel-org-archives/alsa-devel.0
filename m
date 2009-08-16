From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: SNDRV_PCM_TRIGGER_STOP and audio still queued in
	the driver
Date: Sat, 15 Aug 2009 23:40:36 -0400
Message-ID: <9e4733910908152040g1f229833x37bde85264f98a7f@mail.gmail.com>
References: <9e4733910908150806x38a395bev99f042a563d76edf@mail.gmail.com>
	<9e4733910908150853k60d76150n2130fe217b432d1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f176.google.com (mail-yx0-f176.google.com
	[209.85.210.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 0037E24670
	for <alsa-devel@alsa-project.org>;
	Sun, 16 Aug 2009 05:41:00 +0200 (CEST)
Received: by yxe6 with SMTP id 6so2890841yxe.16
	for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2009 20:40:37 -0700 (PDT)
In-Reply-To: <9e4733910908150853k60d76150n2130fe217b432d1e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 15, 2009 at 11:53 AM, Jon Smirl<jonsmirl@gmail.com> wrote:
> void
> bfio_synch_stop(void)
> {
> =A0 =A0int n;
>
> =A0 =A0if (base_handle =3D=3D NULL) {
> =A0 =A0 =A0 =A0return;
> =A0 =A0}
> =A0 =A0FOR_IN_AND_OUT {
> =A0 =A0 =A0 =A0for (n =3D 0; n < n_handles[IO]; n++) {

I added:
snd_pcm_nonblock(handles[IO][n], 0)
snd_pcm_drain(handles[IO][n])
snd_pcm_nonblock(handles[IO][n], SND_PCM_NONBLOCK )

> =A0 =A0 =A0 =A0 =A0 =A0snd_pcm_close(handles[IO][n]);
> =A0 =A0 =A0 =A0}
> =A0 =A0}
> }

This is not working correctly.
snd_pcm_nonblock(handles[IO][n], 0)
It does not remove O_NONBLOCK for some unknown reason.

I added printf() to snd_pcm_hw_nonblock()
The fcntl is not getting an error.
	if (fcntl(fd, F_SETFL, flags) < 0) {
Flags being set are 2 (O_RDWR).

But when I get over to snd_pcm_pre_drain_init(), I get the -EAGAIN error.
static int snd_pcm_pre_drain_init(struct snd_pcm_substream *substream,
int state)
{
	printk("snd_pcm_pre_drain_init\n");
	if (substream->f_flags & O_NONBLOCK)
		return -EAGAIN;
	printk("snd_pcm_pre_drain_init 1\n");
	substream->runtime->trigger_master =3D substream;
	return 0;
}
So I have to conclude that fcntl(fd, F_SETFL, flags) is not removing
the O_NONBLOCK flag.

If I change the inital PCM open to be blocking everything works as expected.




-- =

Jon Smirl
jonsmirl@gmail.com
