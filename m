From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: parallel, real time safe waiting?
Date: Tue, 14 Apr 2015 14:35:36 +0200
Message-ID: <552D0998.4080806@ladisch.de>
References: <trinity-43de15d6-c64e-46fe-80ab-acaeb4930fc6-1428947762351@3capp-gmx-bs04>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id ADBCE26054A
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 14:35:37 +0200 (CEST)
In-Reply-To: <trinity-43de15d6-c64e-46fe-80ab-acaeb4930fc6-1428947762351@3capp-gmx-bs04>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Johannes Lorenz <johannes89@mailueberfall.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Johannes Lorenz wrote:
>   1.) Let each thread open a handle using snd_seq_open()
>   2.) Call snd_pcm_wait() in each thread

> Are these functions
>
>   a) real time safe?

snd_seq_open() is not, but why would that matter?
Don't you call it from the GUI thread?

>   b) race-condition free, assuming I'll use pairwise different handles each thread

Yes.


Regards,
Clemens
