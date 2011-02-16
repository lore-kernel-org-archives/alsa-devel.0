From: "Sebastian H." <vand2@gmx.de>
Subject: Re: alsa-lib: snd_mixer_selem_is_active changes -
 which event?
Date: Wed, 16 Feb 2011 09:38:36 +0100
Message-ID: <4D5B8D0C.9080303@gmx.de>
References: <4D5ACED8.5030707@gmx.de> <4D5B8D23.2080107@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id 02C432448E
	for <alsa-devel@alsa-project.org>; Wed, 16 Feb 2011 10:11:01 +0100 (CET)
In-Reply-To: <4D5B8D23.2080107@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Am 16.02.2011 09:38, schrieb Clemens Ladisch:
> Sebastian H. wrote:
>> I wonder which event mask notifies an application that
>> snd_mixer_selem_is_active() may have changed.
>>
>> SND_CTL_EVENT_MASK_VALUE
>> or
>> SND_CTL_EVENT_MASK_INFO
> 
> _VALUE is only for the value itself; all metadata changes
> generate an _INFO event.

Great, that justifies the removal of some bloated
constructions in qasmixer. :)

Thanks a lot!

Regards,
Sebastian H.
