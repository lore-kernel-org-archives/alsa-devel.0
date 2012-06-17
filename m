From: Benjamin Sion <ml_all@circa.be>
Subject: Re: [PATCH] USB: fix gathering of interface
	associations
Date: Sun, 17 Jun 2012 14:41:51 +0200
Message-ID: <4FDDD08F.6040003@circa.be>
References: <1339525432-22039-1-git-send-email-zonque@gmail.com>
	<4FD9C7D2.8030506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo3.mail-out.ovh.net (20.mo3.mail-out.ovh.net [178.33.47.94])
	by alsa0.perex.cz (Postfix) with ESMTP id 4387C243F6
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Jun 2012 14:41:54 +0200 (CEST)
Received: from mail181.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 2A51BFF8391
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Jun 2012 14:45:55 +0200 (CEST)
In-Reply-To: <4FD9C7D2.8030506@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, ivanperrone@hotmail.com, sarah.a.sharp@linux.intel.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, sergio tabanelli <sergio.tabanelli@gmail.com>, stern@rowland.harvard.edu
List-Id: alsa-devel@alsa-project.org

On 14/06/12 13:15, Daniel Mack wrote:
> On 12.06.2012 20:23, Daniel Mack wrote:
>> TEAC's UD-H01 (and probably other devices) have a gap in the interface
>> number allocation of their descriptors:
> 
> I now got a report from Sergio Tabanelli who tried this patch on real
> hardware, and he confirmed the fix. I added some more people to the
> patch description and copied stable@ as well.

Your patch just tested here on real hardware (TEAC UD-H01), I confirm it
works: interface is registered (despite UD-H01's buggy descriptors).

Thanks!

bEN
