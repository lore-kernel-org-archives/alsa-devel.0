From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: SPDIF and cs46xx ?
Date: Mon, 31 Mar 2003 15:58:55 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.50.0303311553470.19488-100000@cactus>
References: <14a4584ea6cb4a6894e70d84e717abc6.peter599@gotnet.net>
 <3E75075E.7030401@cucumelo.org> <20030329142035.GA16590@ulima.unil.ch>
 <3E864424.6060707@cucumelo.org> <20030330144633.GA9474@ulima.unil.ch>
 <3E874714.5020302@cucumelo.org> <20030331115057.GB3187@wotan.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030331115057.GB3187@wotan.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Dr. Werner Fink" <werner@suse.de>
Cc: Gregoire Favre <greg@ulima.unil.ch>, Peter Heatwole <peter599@gotnet.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> If mmap is used in the bitstreamout plugin the period size is 1024 bytes or
> 256 stereo PCM samples. Does this work with the cs46xx hw?
Yes, 1024 _bytes_ period size should be supported by block DMA.
The following period sizes are supported: 2048, 1024, 512, 256, 64, 32 
bytes.

> See my former mail how this could be done if the hardware allows direct
> access to the S/P-DIF out (e.g. raw out with 96kHz for effective 49kHz
> sample frequence of the PCM data).
The current cs46xx driver only supports raw 48khz output. I'm not sure, 
but maybe  it's possible to set the SPDIF controller to 96khz. I need to 
check this.

/Benny


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
