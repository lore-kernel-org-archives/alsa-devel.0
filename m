From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Test device for automated testing
Date: Wed, 16 Sep 2015 16:30:21 +0200
Message-ID: <55F97CFD.9080608@ladisch.de>
References: <55F9617A.6040301@weiss.ch> <55F96798.70106@ladisch.de>
 <55F96B5A.6000900@weiss.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id D801C261555
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 16:30:23 +0200 (CEST)
In-Reply-To: <55F96B5A.6000900@weiss.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Uli Franke <uli.franke@weiss.ch>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Uli Franke wrote:
> I tried the "null" but this fails when setting hw parameters with an
> assertion.

In theory, the null device does not have any restrictions.  But an
assertion indicates a programming error (somewhere).  What is the
message, and what are the hw parameters?


Regards,
Clemens
