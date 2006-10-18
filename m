From: Daniel Yek <dyek@real.com>
Subject: Multichannels channel-mapping application API for PCM?
Date: Wed, 18 Oct 2006 16:53:09 -0700
Message-ID: <6.2.1.2.2.20061018160033.5bab2b70@mailone.real.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

First of all, thanks for the previous responses that I got. All that was 
very helpful. More questions here...

What is the rational behind ALSA's PCM multichannel playback channel 
assignment? ALSA appears to be using the following channel assignment:

5.1 Channels Channel Assignment:
0: Front left
1: Front right
2: Rear Left
3: Rear Right
4. Center
5. LFE

Is this the only format ALSA supported? Why/how it was selected in the 
beginning? (Just curious about the history...)

I think (not sure, really) the channel assignment for Windows (if it is 
really one standard there) is:
0: Front left
1: Front right
2: Center
3: LFE
4. Rear Left
5. Rear Right

I haven't investigated AC3 (Dolby Digital) yet, anybody knows if there is a 
format for channel assignment there?

I'm looking if there is a solution (application API) provided by ALSA to do 
channel-mapping. If there is one, I can just ask ALSA to do the 
"heavy-lifting" of swapping the surround sound channels. If not, I'll 
iterate through the PCM data, mapping the channels to the format expected 
by ALSA.

I read about channel bindings in configuration files, but that isn't an 
application API that media application can use and it requires the end 
users to mess with their system. So, that isn't a real solution. Is there 
anything else that is available?

As always, thanks.


-- 
Daniel Yek


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
