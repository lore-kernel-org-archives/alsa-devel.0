From: "Rich E" <reakinator@gmail.com>
Subject: vu meter plugin for hdsp soundcards
Date: Mon, 5 Mar 2007 02:42:14 -0800
Message-ID: <a3297bc90703050242p7b08e8en933a5927ee55013c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1718102503=="
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

--===============1718102503==
Content-Type: multipart/alternative;
	boundary="----=_Part_49042_30601646.1173091334857"

------=_Part_49042_30601646.1173091334857
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi list,

I'd like to write a simple plugin for PureData that will monitor the levels
of my hdsp multiface ins and outs, to get some of the functionality of
hdspmixer into pd.  The levels can be set ( within pd ) using an external
that allows shell commands like amixer ( [shell] in pd-extended), but I
can't find how to monitor the signal in pd.

I think I need to find where to get RMS readings of the outputs and inputs
using the libasound library... can anyone point me in the right direction?

Thanks,
rich

------=_Part_49042_30601646.1173091334857
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi list,<br><br>I&#39;d like to write a simple plugin for PureData that will monitor the levels of my hdsp multiface ins and outs, to get some of the functionality of hdspmixer into pd.&nbsp; The levels can be set ( within pd ) using an external that allows shell commands like amixer ( [shell] in pd-extended), but I can&#39;t find how to monitor the signal in pd.&nbsp; 
<br><br>I think I need to find where to get RMS readings of the outputs and inputs using the libasound library... can anyone point me in the right direction?<br><br>Thanks,<br>rich<br>

------=_Part_49042_30601646.1173091334857--


--===============1718102503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1718102503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1718102503==--
