From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 8/8] ALSA: control: arrange snd_ctl_new()
 as a local function
Date: Wed, 11 Feb 2015 13:49:29 +0100
Message-ID: <54DB4FD9.30608@metafoo.de>
References: <1423651052-19593-1-git-send-email-o-takashi@sakamocchi.jp>
 <1423651052-19593-9-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-161.synserver.de (smtp-out-161.synserver.de
 [212.40.185.161])
 by alsa0.perex.cz (Postfix) with ESMTP id 28E972605DF
 for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2015 13:49:31 +0100 (CET)
In-Reply-To: <1423651052-19593-9-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/11/2015 11:37 AM, Takashi Sakamoto wrote:
[...]
> -/**
> - * snd_ctl_new - create a control instance from the template
> - * @control: the control template
> - * @access: the default control access
> - *
> - * Allocates a new struct snd_kcontrol instance and copies the given template
> - * to the new instance. It does not copy volatile data (access).
> - *
> - * Return: The pointer of the new instance, or %NULL on failure.
> - */
> -static struct snd_kcontrol *snd_ctl_new(struct snd_kcontrol *control,
> -					unsigned int access)
> +static struct snd_kcontrol *ctl_new(struct snd_kcontrol *control,

I'd prefer to keep both the documentation as well as the 'snd_' prefix. 
Maybe just replace the '/**' with '/*' to prevent it from appearing in the 
public API documentation.

- Lars
