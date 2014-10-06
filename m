From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH v2] alsa-tools: Add a small
 "hdajacksensetest" helper
Date: Mon, 6 Oct 2014 22:56:45 +0800
Message-ID: <CAN8ccibgX4_L+v6wLLcuZsVXHP+Zh2tCCy1suDHbv959KXm7vQ@mail.gmail.com>
References: <1412602203-15787-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f51.google.com (mail-qg0-f51.google.com
 [209.85.192.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 86608260625
 for <alsa-devel@alsa-project.org>; Mon,  6 Oct 2014 16:56:46 +0200 (CEST)
Received: by mail-qg0-f51.google.com with SMTP id z107so3737887qgd.24
 for <alsa-devel@alsa-project.org>; Mon, 06 Oct 2014 07:56:45 -0700 (PDT)
In-Reply-To: <1412602203-15787-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> I previously had a small python script doing the same thing,
> but it depended on hda-analyzer, which always breaks when something
> new is added to the codec proc file.
>
> I got tired and rewrote it as a small C program instead, which I
> hope will be a useful addition to alsa-tools.
>

> +
> +static gboolean should_check_pin(pin_configs_t *pin)
> +{
> +       unsigned long defcfg = actual_pin_config(pin);
> +       if (try_all_pins)
> +               return TRUE;
> +       if (get_port_conn(defcfg) != 0)
> +               return FALSE; // Not a jack
> +       if (defcfg & (1 << 8)) // Jack has NO_PRESENCE set
> +               return FALSE;
> +       return TRUE;
> +}
> +

The pincap of the pin complex must support DETECT even when you specify
try_all_pins
