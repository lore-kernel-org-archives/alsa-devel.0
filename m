From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Playing mono files on a stereo only device
Date: Fri, 18 Mar 2016 19:37:43 +0100
Message-ID: <56EC4AF7.80001@ladisch.de>
References: <1458318844851.58479@amazon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id E5CE5264FF6
 for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2016 19:38:13 +0100 (CET)
In-Reply-To: <1458318844851.58479@amazon.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Champ, Andy" <andycham@amazon.co.uk>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Champ, Andy wrote:
> Currently the error I am having indicates that it's a problem with access.

The access must be "interleaved".

> I've not even been able to decide if an access is meant to be a mask or a value.

The access type itself is a single value.
But the set of all possible hardware parameters contains a bit mask.


Regards,
Clemens
