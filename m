From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] davinci-mcasp: correct tdm_slots limit
Date: Tue, 26 Apr 2011 11:46:36 +0100
Message-ID: <20110426104635.GA13252@opensource.wolfsonmicro.com>
References: <cover.1303408522.git.bengardiner@nanometrics.ca>
	<e6aa9fd05c44088ab8446f1c60d2056f92929483.1303408522.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4F3C9243B7
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Apr 2011 12:46:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <e6aa9fd05c44088ab8446f1c60d2056f92929483.1303408522.git.bengardiner@nanometrics.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, James Nuss <jamesnuss@nanometrics.ca>, Sekhar Nori <nsekhar@ti.com>, davinci-linux-open-source@linux.davincidsp.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 21, 2011 at 02:19:01PM -0400, Ben Gardiner wrote:
> The current check for the number of tdm-slots specified by platform data is
> always true (x >= 2 || x <= 32); therefore the else branch that warns of an
> incorrect number of slots can never be taken.

Applied all of these.  Please always try to ensure that your commit logs
are consistent with the rest of the subsystem so they don't need to be
rewritten.
