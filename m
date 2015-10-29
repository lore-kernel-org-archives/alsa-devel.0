From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Unknown PCM cards.pcm.front
Date: Thu, 29 Oct 2015 13:47:03 +0100
Message-ID: <56321547.7080508@ladisch.de>
References: <14E6E6A6-54AE-4EB5-8106-791B95650733@latencyzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 961D126057D
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 13:47:09 +0100 (CET)
In-Reply-To: <14E6E6A6-54AE-4EB5-8106-791B95650733@latencyzero.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rick Mann <rmann@latencyzero.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rick Mann wrote:
> "ALSA lib pcm.c:2217:(snd_pcm_open_noupdate) Unknown PCM cards.pcm.front"

This means that some code tried to open device named "front", and that there
is no such definition for your hardware.


Regards,
Clemens
