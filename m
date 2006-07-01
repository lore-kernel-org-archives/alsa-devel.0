From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: sound connector detection
Date: Sat, 1 Jul 2006 16:09:58 -0400
Message-ID: <200607011609.59426.dtor@insightbb.com>
References: <1151671786.13412.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1151671786.13412.6.camel@localhost>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>, Richard Purdie <rpurdie@rpsys.net>, alsa-devel@lists.sourceforge.net, Linux Kernel list <linux-kernel@vger.kernel.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Friday 30 June 2006 08:49, Johannes Berg wrote:
> Hi,
> 
> One Apple machines I have with snd-aoa the situation that the alsa
> driver can detect changes in in/output connector state ("is headphone
> plugged in" etc.) and currently surfaces it through a read-only alsa
> mixer element. That isn't really ideal since nothing is prepared to
> handle such events, hence I provide an additional control that allows an
> in-kernel toggle from speakers to headphone on headphone plug (and vice
> versa).
> 
> I'd really like to see this handled in userspace (additionally or
> possibly event instead), since there are complications especially with
> input (line-in) detection and user preferences of what should happen
> then. The number of cases can become large, especially when throwing in
> digital and combo connectors that aren't handled yet.
> 
> Now, is it appropriate to create an input device for the state of these
> things and add new constants like SW_LINEIN_INSERTED,
> SW_LINEOUT_INSERTED, SW_OPTICALOUT_INSERTED, SW_OPTICALIN_INSERTED and
> if so, how do I reflect the fact that on some machines optical and
> analog input/output is mutually exclusive, while on others it isn't?
> That would probably require another SW_COMBO_IN/OUT set...
> 
> Or should I simply stick with (a) read-only mixer control(s), and for
> the mutually exclusive case create a tristate (none, optical, analog)
> one? But SW_HEADPHONE_INSERT already exists, so we may want to do this
> identically on different machines.
> 

Hi Johannes,

I am not too happy with putting this kind of switches into input layer,
it should be reserved for "real" buttons, ones that user can explicitely
push or toggle (lid switch is on the edge here but it and sleep button
are used for similar purposes so it makes sense to have it in input layer
too). But "cable X connected" kind of events is too much [for input layer,
there could well be a separate layer for it]. If we go this way we'd have
to move cable detection code from network to input layer as well ;)

-- 
Dmitry

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
