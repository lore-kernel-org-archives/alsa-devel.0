From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Bug in emu10k1 multichannel support
Date: Thu, 10 Feb 2005 22:55:18 -0500
Message-ID: <1108094119.16799.2.camel@krustophenia.net>
References: <1106091073.24484.60.camel@krustophenia.net>
	 <s5hpt01tler.wl@alsa2.suse.de> <1106970885.3051.88.camel@krustophenia.net>
	 <41FE5838.4060907@glocalnet.net>
	 <1108073865.11177.6.camel@krustophenia.net>
	 <420BEF63.60402@machinehasnoagenda.com>
	 <1108083562.15438.4.camel@krustophenia.net>
	 <420C0BE5.3060008@machinehasnoagenda.com>
	 <1108085587.15438.6.camel@krustophenia.net>
	 <420C18EC.3060706@machinehasnoagenda.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <420C18EC.3060706@machinehasnoagenda.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Shayne O'Connor <forums@machinehasnoagenda.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-02-11 at 13:31 +1100, Shayne O'Connor wrote:
> ok, i did that, but when i try to compile alsa-driver i get the output
> below ... but just to clear up - with patches before 009, i only had to
> compile and install the alsa-driver module (i'm using PlanetCCRMA which
> loads alsa as a kernel module), is that the case here as well?
> 
> if not, could you give me a run-through of how i would install the whole
> pattched alsa package on top of what i've already got there? i realise
> you're busy, but it would help a great deal in making sure i'm testing
> these patches correctly :)
> 
> here is the ouput from trying to compile alsa-driver:

The procedure is exactly the same.  With all versions of the patch you
should apply using patch -p1 from the main ALSA directory (the one
containing the alsa-driver, alsa-kernel, alsa-lib, alsa-tools, etc.
directories).

I don't know what those errors are.  They have nothing to do with my
patch.  Either you are doing something wrong, or current ALSA CVS just
does not compile.

Please wait for ALSA 1.0.9 which should have the multichannel support
included if you can't get it to work.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
