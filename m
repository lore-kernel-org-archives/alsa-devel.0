From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Automatic assignment/configuration of model-id?
Date: Thu, 30 Oct 2008 10:13:58 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0810301011120.12044@tm8103.perex-int.cz>
References: <d9690f190810300202l2ba7588j91823da236d4b65d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 95459246F5
	for <Alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 10:13:58 +0100 (CET)
In-Reply-To: <d9690f190810300202l2ba7588j91823da236d4b65d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Klaus Schulz <kls.schlz@googlemail.com>
Cc: ALSA development <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 30 Oct 2008, Klaus Schulz wrote:

> Hi gents.
> 
> To take full advantage of the driver I need to assign the right model 
> option to the module
> - as far as I understand - manually.

Hi,

The driver should detect the model automatically. If model is not 
detected properly - please, send a report to this ML with link to 
contents from 'alsa-info.sh' script and we add an entry for specific
hardware to the driver.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
