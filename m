From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: endianness problems in fireworks/bebob_maudio
Date: Mon, 08 Dec 2014 09:09:09 +0100
Message-ID: <54855CA5.5070307@ladisch.de>
References: <5484C572.7040606@ladisch.de> <5484E69E.1000009@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id C0CF6260430
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 09:09:14 +0100 (CET)
In-Reply-To: <5484E69E.1000009@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> For my information, Would you tell me the way to generate these sparse
> report?

make C=1 CF=-D__CHECK_ENDIAN__


Regards,
Clemens
