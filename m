From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: opening rawmidi on user ports
Date: Wed, 13 Mar 2019 18:29:02 +0100
Message-ID: <73551cff-9856-5060-b587-010291c604c2@ladisch.de>
References: <9c82e740-a327-3809-875c-3eb4f01945e8@gmail.com>
 <16e0299a-549b-951b-a3e9-5d70be8b3ad5@ladisch.de>
 <513b5f87-3bb9-8147-b249-75aa4a100341@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D566F8961E
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2019 18:30:41 +0100 (CET)
In-Reply-To: <513b5f87-3bb9-8147-b249-75aa4a100341@gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: AlGrenadine <a.granvaud@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

AlGrenadine wrote:
> it seems ALSA seq looses sysex messages. Is there a buffer size which can be set ?

Messages from where to where?  Can you check with aseqdump or "amidi --dump"?

Messages that are too large for the internal buffer are split into multiple parts.


Regards,
Clemens
