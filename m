From: Rimas Kudelis <rq@akl.lt>
Subject: Re: [PATCH] hda: ALC260 test model implementation
Date: Thu, 09 Feb 2006 07:59:21 +0200
Message-ID: <43EADA39.8070900@akl.lt>
References: <200602062250.k16Mo0XK012879@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200602062250.k16Mo0XK012879@auster.physics.adelaide.edu.au>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jonathan Woithe wrote:
> Hi
> 
> The following patch adds a "test" ALC260 model specification to the
> patch_realtek.c driver if CONFIG_SND_DEBUG is set.  This is similar to the
> "test" ALC880 model in that it sets up mixer controls for almost everything
> to make it easier for people to test their laptop/soundcard when working out
> what pin widgets are connected to which real-world devices.

<...>
> +#ifdef CONFIG_SND_DEBUG
<...>

Just a thought - wouldn't it be better to always compile this model 
in, regardless of whether CONFIG_SND_DEBUG is enabled or not? I can't 
think of any problem that just the presence of this model in the 
driver could cause. Also, I doubt that popular distros would compile 
their alsa drivers *with* CONFIG_SND_DEBUG enabled, so again, this 
would only prevent people from testing their hardware and submitting 
the results to the developers. For example, I know how to 
compile/install ALSA, but i don't know how to compile it with 
CONFIG_SND_DEBUG enabled. :)

I think that all "test" models should be compiled into the drivers by 
default. They don't add much weight to the drivers, but can be found 
very useful in cases where standard models don't work at all (like in 
case of Acer laptops currently). If I had to choose between an 
overbloated mixer, and silence, guess what i would've chosen. ;)



Another idea which someone might want to implement: do you think an 
app for automatic "test" model testing would be useful? I'm thinking 
of a GUI, that would play with mixer controls on its own, and ask the 
user simple questions like "has anything changed now?", or similar, 
letting them provide the answers. After everything has been answered, 
the user could review their answers and/or submit them automatically 
from an app. This would probably simplify the testing. Don't you think so?

Regards,

RQ


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
