From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH - alsa-lib 1/1]
	Introduce	snd_seq_client_info_get_card_number,
	for getting the card number of a seq client on recent kernels
Date: Fri, 05 Jun 2015 08:50:45 +0200
Message-ID: <557146C5.90209@ladisch.de>
References: <1433466312-31444-1-git-send-email-agoode@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 7B38126672E
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 08:50:49 +0200 (CEST)
In-Reply-To: <1433466312-31444-1-git-send-email-agoode@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Goode <agoode@google.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adam Goode wrote:
>  /**
> + * \brief Get the card number of a client_info container
> + * \param info client_info container
> + * \return the card number, -1 if no card associated with this client, or -ENOSYS if the
> + *         kernel does not support reporting this field
> + */

-1 is used as an out-of-range value when enumerating cards.  However,
I don't think this convention can be applied here, because the return
value is also used for error codes, and -1 would correspond to -EPERM.

Squashing all error codes into -1 is not a good idea, so I think the
value -1 should be converted into an appropriate error code, probably
-ENXIO.


Regards,
Clemens
