From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: [RFC PATCH] Inverted internal mic
Date: Wed, 20 Jun 2012 22:53:08 +0100
Message-ID: <CAAMvbhFUicGXUT56DKMm2kZ8y8UmrGxwGQM3efh1sZj9ELa56w@mail.gmail.com>
References: <4F4C9714.1080307@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D6A7024700
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2012 22:31:55 +0200 (CEST)
Received: by vcbgb23 with SMTP id gb23so2732086vcb.38
	for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2012 14:53:08 -0700 (PDT)
In-Reply-To: <4F4C9714.1080307@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, 903853@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

On 28 February 2012 08:57, David Henningsson
<david.henningsson@canonical.com> wrote:
> Hi,
>
> One of the more common problems on laptop machines, is that the internal mic
> provides a stereo signal but with one channel phase inverted, or
> differential output.
>
> This means problems for applications recording two channels but later
> merging them into one, leaving them with zero or near-zero output.
>

If the mic capture looks phase inverted, this might actually be a way
to reduce common mode noise on the pickup.
It might be a differential input for improved dynamic range.
In which case, just dropping one of the channels is not the best,
quality wise, option.
To get the highest quality output, it might be best to do a
differential calculation.
I.e. Channel A - Channel B.
The problem being, if the input is 16bits, the Channel A - Channel B is 17bits.
Can any tests be done to see if Channel A - Channel B has a better S/N
ratio than simply dropping channel B, and copy channel A to channel B?

Kind Regards

James
