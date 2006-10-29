From: Ricardo Cerqueira <alsa-users@cerqueira.org>
Subject: Re: (Was Re: [Alsa-user] Poorly supported HDA intel)
Date: Sun, 29 Oct 2006 12:45:04 +0100
Message-ID: <01cec9d04b9a4e60c355061dd0ca28c3@192.168.1.254>
References: <s5hirib1cx4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hirib1cx4.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi again;

On Mon, 23 Oct 2006 13:36:55 +0200, Takashi Iwai <tiwai@suse.de> wrote:

>>
>> Which version of kernel and gcc are you using?  It has worked fine
>> with my machines, 2.6.18, 19-git and gcc 4.1.

2.6.18 (fedora's version), and gcc 4.1.1

> 
> Possibly you're using snd_compat_vsnprintf() fuction and this looks
> broken for over-4k strings.  But, this wrapper is necessary only for
> pretty old kernels.  All 2.6 kernels should have a native
> vsnprintf().  Check whether alsa-driver/include/config.h whether you
> have CONFIG_HAVE_VSNPRINTF there.  If not, check config.log for
> details.

I do have it defined, so that's not it, either...

--
RC


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
