From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Disagreement about versions following CVS update
Date: Fri, 19 Aug 2005 19:47:26 -0400
Message-ID: <1124495247.25424.101.camel@mindpipe>
References: <43063408.60402@redfish-solutions.com>
	 <1124483804.25424.50.camel@mindpipe>
	 <43064B0B.9080402@redfish-solutions.com>
	 <1124486050.25424.52.camel@mindpipe>
	 <43065A7F.6070904@redfish-solutions.com>
	 <1124490358.25424.72.camel@mindpipe>
	 <43066945.7020405@redfish-solutions.com>
	 <1124494135.25424.98.camel@mindpipe>
	 <43066E9A.3010705@redfish-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43066E9A.3010705@redfish-solutions.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Philip Prindeville <philipp_subx@redfish-solutions.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-08-19 at 17:43 -0600, Philip Prindeville wrote:
> nd_seq_device: disagrees about version of symbol snd_info_register
> snd_seq_device: Unknown symbol snd_info_register
> snd_seq_device: disagrees about version of symbol 
> snd_info_create_module_entry 

Did you make sure to remove the previous modules with rmmod before
modprobe'ing the new ones?

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
