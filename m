From: Mark Knecht <markknecht@comcast.net>
Subject: Re: aoss failures under Alsa-1.0.0rc1
Date: Thu, 04 Dec 2003 05:12:01 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1070543521.3012.0.camel@Wizard.knechthome.com>
References: <1070543197.2081.30.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1070543197.2081.30.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2003-12-04 at 05:06, Mark Knecht wrote:
> bash-2.05b$ aoss xmms
> 
> (At this point the xmms gui opens. I then press play)
> 
> xmms: alsa-oss.c:222: oss_dsp_hw_params: Assertion `err >= 0' failed.
> /usr/bin/aoss: line 9:  2841 Aborted                
> LD_PRELOAD=${exec_prefix}/lib/libaoss.so $*
> bash-2.05b$ 
> 

BTW - hdspconf says that aoss xmms sets the sample rate to 48K when this
fails, even though the media is recorded at 44.1K.



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
