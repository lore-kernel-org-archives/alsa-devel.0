From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH - ALSA: snd-virtuoso 1/1] Xonar DSX support
Date: Sun, 09 Sep 2012 12:03:31 +0200
Message-ID: <504C6973.6050308@ladisch.de>
References: <504b9831.aac4320a.1f39.ffff8a9f@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <504b9831.aac4320a.1f39.ffff8a9f@mx.google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: sgiurgiu11@gmail.com
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

sgiurgiu11@gmail.com wrote:
> From: Sergiu Giurgiu <sgiurgiu11@gmail.com>
>
> Signed-off-by: Sergiu Giurgiu <sgiurgiu11@gmail.com>

Many thanks for writing this patch!
However, please mention which features work, don't work, or aren't tested.

> +++ b/mirror/sound/pci/oxygen/xonar_wm87x6.c
>
> +static const struct oxygen_model model_xonar_dsx = {
> +	.shortname = "Xonar DSX",
> +     ...

This structure is almost the same as model_xonar_ds; please merge
them.  (See xonar_cs43xx.c for an example.)


Regards,
Clemens
