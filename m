From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Crackling in USB audio capture
Date: Fri, 27 Mar 2009 04:55:35 +0000
Message-ID: <20090327045535.GP3051@decadent.org.uk>
References: <20090325223553.GO3051@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="STPqjqpCrtky8aYs"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
	[88.96.1.126]) by alsa0.perex.cz (Postfix) with ESMTP id 56DA410387C
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2009 05:55:37 +0100 (CET)
Received: from womble by shadbolt.decadent.org.uk with local (Exim 4.69)
	(envelope-from <ben@decadent.org.uk>) id 1Ln46R-0006rQ-QT
	for alsa-devel@alsa-project.org; Fri, 27 Mar 2009 04:55:35 +0000
Content-Disposition: inline
In-Reply-To: <20090325223553.GO3051@decadent.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--STPqjqpCrtky8aYs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, 2009-03-25 at 22:35 +0000, Ben Hutchings wrote:
> I'm writing an ALSA application that captures audio.  It worked OK with
> PCI sound cards but is somehow getting regular faint clicking/crackling
> with a USB audio device (TI/Burr-Brown PCM2902).  Source code is below.
> What am I doing wrong?

FWIW, the bug was in the function I didn't post...  Fixed now.

Ben.


--STPqjqpCrtky8aYs
Content-Disposition: inline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"


--STPqjqpCrtky8aYs
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--STPqjqpCrtky8aYs--
