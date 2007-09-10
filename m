From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: [Alsa-user] Disable MIDI port creation with ICE1724
Date: Mon, 10 Sep 2007 10:02:53 +0200
Message-ID: <1189411373.11020.1209774393@webmail.messagingengine.com>
References: <a98f20490709071832i7491b9bdl374e36ceee396087@mail.gmail.com>
	<46E33D05.6080704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id AC4D4103845
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Sep 2007 10:02:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46E33D05.6080704@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>, James Roberts <jaaxxster@gmail.com>
Cc: alsa-user@lists.sourceforge.net, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:
> On 09/08/2007 03:32 AM, James Roberts wrote:
> > I need to disable the creation of the ICEnsemble ICE1724 midi device on 
> > my system.  I am using a off-brand card (see below) and accessing the 
> > midi device crashes the system hard.
> 
> Sounds like this may warrent a module parameter. Trivial, untested version 
> below, but this needs a module maintainer to decide if there may be better 
> ways to discriminate.

It would be better to autodetect the card, i.e., add a new entry to
card_tables[].

Does this card have some unique ID? (see /proc/asound/cardX/ice1724 and
the output of "lspci -v" for this device)


Regards,
Clemens
