From: Peter Heatwole <peter599@gotnet.net>
Subject: Re: cs46xx experimental DSP drivers
Date: Tue, 24 Sep 2002 18:00:13 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020925010013.GC990@porky>
References: <3D8F7F59.6030105@prism.gatech.edu> <3D90A8D8.7070103@cucumelo.org> <3D90B54F.20402@prism.gatech.edu> <3D90D641.7050200@cucumelo.org> <3D90FEF4.2040309@prism.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3D90FEF4.2040309@prism.gatech.edu>; from gte733z@prism.gatech.edu on Tue, Sep 24, 2002 at 17:10:28 -0700
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Weijia Yang <gte733z@prism.gatech.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 2002.09.24 17:10 Weijia Yang wrote:
> I am attempting to use the debug code, but after defining I get the
> following errors during compile:
[snip]


    You probably just stuck a define in cs46xx_lib.c.  Append the 
following into alsa-driver/pci/cs46xx/Makefile, to the end of the
EXTRA_FLAGS line:

-DCONFIG_SND_CS46XX_DEBUG_GPIO=1


HTH,
-- Peter Heatwole
"Murphy was just a well known pessimist."



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
