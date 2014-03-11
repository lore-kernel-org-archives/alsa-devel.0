From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] add Steinberg UR44 USB Audio Interface
 support to quirks-table
Date: Tue, 11 Mar 2014 09:31:08 +0100
Message-ID: <531EC9CC.4060203@ladisch.de>
References: <1394388767-23658-1-git-send-email-cyrus@bobobeach.com>
 <531DAB14.5080201@ladisch.de>
 <76F78615-8762-4A6C-B601-97380805F450@bobobeach.com>
 <531DDD04.5050902@ladisch.de>
 <0EFBCC9F-93CA-4368-9530-B9049B3743FB@bobobeach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 762B4261622
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 09:31:09 +0100 (CET)
In-Reply-To: <0EFBCC9F-93CA-4368-9530-B9049B3743FB@bobobeach.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cyrus Harmon <cyrus@bobobeach.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cyrus Harmon wrote:
> On Mar 10, 2014, at 8:40 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
>> In theory, kernel 3.11 and later should support this device without
>> a quirk entry.  I guess it actually does not?
>
> no, the stock kernel doesn=92t support this device.

Strange; in theory, the driver should be able to pick up these
descriptors.

Are there any error messages in the system log when you plug it in or
reload the unpatch snd-usb-audio driver?


Regards,
Clemens
