From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 0/4] FIFO caused playback delay
	(latency)	handling in soc
Date: Wed, 3 Mar 2010 10:03:04 +0000
Message-ID: <20100303100303.GA10251@sirena.org.uk>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
	<4f3252891003021529h4cfe22a4wb5d8217da298a94f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E9E510394E
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 11:03:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4f3252891003021529h4cfe22a4wb5d8217da298a94f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 03, 2010 at 07:29:23AM +0800, Raymond Yau wrote:

> Do soc support snd_pcm_rewind() and snd_pcm_forward ?

No driver demand yet, though it'd be trivially implemented if anyone
wanted to do it.
