From: Dave Airlie <airlied@gmail.com>
Subject: Re: [alsa-devel] [PATCH 0/2] HD-audio HDMI regression fixes with
	VGA-switcheroo
Date: Sat, 9 Jun 2012 08:57:20 +0100
Message-ID: <CAPM=9twG6PUZCn56Gt+A3HfGCnJ_5iQMqRZeaZBTxv1tSxfo1Q@mail.gmail.com>
References: <1339064116-18579-1-git-send-email-tiwai@suse.de>
	<4FD1E181.4030805@web.de> <s5h4nqmrm4q.wl%tiwai@suse.de>
	<4FD21E0D.1050405@web.de> <s5hfwa56bso.wl%tiwai@suse.de>
	<4FD25DD9.3030705@web.de> <s5haa0d566s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <s5haa0d566s.wl%tiwai@suse.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, =?ISO-8859-1?Q?J=F6rg=2DVolker_Peetz?= <jvpeetz@web.de>, dri-devel@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

> Good to hear.
> Dave, is it OK to apply the patch below through sound tree?

ack below,
>
>
> thanks,
>
> Takashi
>
> ---
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] vga_switcheroo: Enable/disable audio clients at the righ=
t time
>
> The audio clients have to be disabled before disabling the VGA and
> switching. =A0Similarly, enabling the audio client should be done at
> last. =A0Otherwise the audio-side operation stalls, eventually leading
> to Oops or lockups.
>
> Tested-by: J=F6rg-Volker Peetz <jvpeetz@web.de>

Acked-by: Dave Airlie <airlied@redhat.com>

> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> =A0drivers/gpu/vga/vga_switcheroo.c | =A0 14 ++++++++------
> =A01 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switc=
heroo.c
> index 38f9534..e24ad99 100644
> --- a/drivers/gpu/vga/vga_switcheroo.c
> +++ b/drivers/gpu/vga/vga_switcheroo.c
> @@ -291,8 +291,6 @@ static int vga_switchto_stage1(struct vga_switcheroo_=
client *new_client)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vga_switchon(new_client);
>
> =A0 =A0 =A0 =A0vga_set_default_device(new_client->pdev);
> - =A0 =A0 =A0 set_audio_state(new_client->id, VGA_SWITCHEROO_ON);
> -
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -308,6 +306,8 @@ static int vga_switchto_stage2(struct vga_switcheroo_=
client *new_client)
>
> =A0 =A0 =A0 =A0active->active =3D false;
>
> + =A0 =A0 =A0 set_audio_state(active->id, VGA_SWITCHEROO_OFF);
> +
> =A0 =A0 =A0 =A0if (new_client->fb_info) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct fb_event event;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0event.info =3D new_client->fb_info;
> @@ -321,11 +321,11 @@ static int vga_switchto_stage2(struct vga_switchero=
o_client *new_client)
> =A0 =A0 =A0 =A0if (new_client->ops->reprobe)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new_client->ops->reprobe(new_client->pdev);
>
> - =A0 =A0 =A0 set_audio_state(active->id, VGA_SWITCHEROO_OFF);
> -
> =A0 =A0 =A0 =A0if (active->pwr_state =3D=3D VGA_SWITCHEROO_ON)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vga_switchoff(active);
>
> + =A0 =A0 =A0 set_audio_state(new_client->id, VGA_SWITCHEROO_ON);
> +
> =A0 =A0 =A0 =A0new_client->active =3D true;
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -371,8 +371,9 @@ vga_switcheroo_debugfs_write(struct file *filp, const=
 char __user *ubuf,
> =A0 =A0 =A0 =A0/* pwr off the device not in use */
> =A0 =A0 =A0 =A0if (strncmp(usercmd, "OFF", 3) =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list_for_each_entry(client, &vgasr_priv.cl=
ients, list) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (client->active)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (client->active || clien=
t_is_audio(client))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_audio_state(client->id,=
 VGA_SWITCHEROO_OFF);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (client->pwr_state =3D=
=3D VGA_SWITCHEROO_ON)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vga_switch=
off(client);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -381,10 +382,11 @@ vga_switcheroo_debugfs_write(struct file *filp, con=
st char __user *ubuf,
> =A0 =A0 =A0 =A0/* pwr on the device not in use */
> =A0 =A0 =A0 =A0if (strncmp(usercmd, "ON", 2) =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list_for_each_entry(client, &vgasr_priv.cl=
ients, list) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (client->active)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (client->active || clien=
t_is_audio(client))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (client->pwr_state =3D=
=3D VGA_SWITCHEROO_OFF)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vga_switch=
on(client);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_audio_state(client->id,=
 VGA_SWITCHEROO_ON);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
> --
> 1.7.10.4
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
