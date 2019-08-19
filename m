From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: SOF: imx: Add i.MX8 HW support
Date: Mon, 19 Aug 2019 09:44:48 +0300
Message-ID: <CAEnQRZAvVs=-pCcNwhWw=wV54jZU5Fu0QAGLnZ8bvK4J3+YRcA@mail.gmail.com>
References: <20190815154500.29090-1-pierre-louis.bossart@linux.intel.com>
 <20190815154500.29090-3-pierre-louis.bossart@linux.intel.com>
 <c8c78674-7af8-4577-9e18-da85c064b345@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 423C7F800AA
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2019 08:45:00 +0200 (CEST)
Received: by mail-wm1-x341.google.com with SMTP id 207so549884wma.1
 for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2019 23:45:00 -0700 (PDT)
In-Reply-To: <c8c78674-7af8-4577-9e18-da85c064b345@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Cezary,

On Sat, Aug 17, 2019 at 6:22 PM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> On 2019-08-15 17:44, Pierre-Louis Bossart wrote:
> > From: Daniel Baluta <daniel.baluta@nxp.com>
> >
> > Add support for the audio DSP hardware found on NXP i.MX8 platform.
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > +static void imx8_get_reply(struct snd_sof_dev *sdev)
> > +{
> > +     struct snd_sof_ipc_msg *msg = sdev->msg;
> > +     struct sof_ipc_reply reply;
> > +     int ret = 0;
> > +
> > +     if (!msg) {
> > +             dev_warn(sdev->dev, "unexpected ipc interrupt\n");
> > +             return;
> > +     }
> > +
> > +     /* get reply */
> > +     sof_mailbox_read(sdev, sdev->host_box.offset, &reply, sizeof(reply));
> > +
> > +     if (reply.error < 0) {
> > +             memcpy(msg->reply_data, &reply, sizeof(reply));
> > +             ret = reply.error;
> > +     } else {
> > +             /* reply has correct size? */
> > +             if (reply.hdr.size != msg->reply_size) {
> > +                     dev_err(sdev->dev, "error: reply expected %zu got %u bytes\n",
> > +                             msg->reply_size, reply.hdr.size);
> > +                     ret = -EINVAL;
> > +             }
> > +
> > +             /* read the message */
> > +             if (msg->reply_size > 0)
> > +                     sof_mailbox_read(sdev, sdev->host_box.offset,
> > +                                      msg->reply_data, msg->reply_size);
> > +     }
> > +
> > +     msg->reply_error = ret;
> > +}
>
> Assuming reply.hdr.size is coming from HW IPC regs, msg object is
> representing application side - SW, kernel. If so, is msg->reply_size
> value an estimated size (which can be overestimated since exact size may
> be unknown by the host) -or- the exact size of incoming IPC reply?
>

I would say msg->reply_size is the exact size of incoming IPC. At least for this
example:

Look at sound/soc/sof/pcm.c

sof_pcm_trigger

-> sof_ipc_tx_message(..,..,&reply, sizeof(reply))

msg->reply_size = sizeof(reply).

On the firmware side:

https://github.com/thesofproject/sof/blob/master/src/ipc/handler.c#L912
reply.rhdr.hdr.size = sizeof(reply);

> The estimated-case is usually permissive as long as assumed size is >=
> reply.hdr.size - dev_err needed. In the exact-case, it should be viewed
> as a requirement. If such "requirement" fails, is it valid to read
> mailbox regardless? Is this to extract some error-debug payload sent by FW?
>
> Just curious, please feel free to correct me here, Pierre.

If you think an improvement can be done, please send a patch :).

thanks,
Daniel.
