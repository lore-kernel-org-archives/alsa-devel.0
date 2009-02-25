From: Clive Messer <clive@vacuumtube.org.uk>
Subject: Re: Timer instability
Date: Wed, 25 Feb 2009 12:34:37 +0000
Message-ID: <200902251234.37222.clive@vacuumtube.org.uk>
References: <20090219024611.GA7930@tango.0pointer.de>
	<s5hiqmyq159.wl%tiwai@suse.de> <s5hfxi2q0il.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_drTpJYSj6ki3C6h"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from abbey4.objectsoft-systems.ltd.uk
	(abbey4.objectsoft-systems.ltd.uk [87.194.123.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 8083C244AE
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 13:34:38 +0100 (CET)
Received: from c7p6t.objectsoft-systems.ltd.uk
	(abbey1.objectsoft-systems.ltd.uk [87.194.123.7])
	(authenticated bits=0)
	by abbey4.objectsoft-systems.ltd.uk (8.14.2/8.14.2) with ESMTP id
	n1PCYb91008612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 12:34:37 GMT
In-Reply-To: <s5hfxi2q0il.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_drTpJYSj6ki3C6h
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 25 Feb 2009 10:22:26 Takashi Iwai wrote:

> Could you check the raw hwptr and applptr values surrounding the error
> time, e.g. with the patch to alsa-lib below?
> If it's really hwsync that makes values unstable, we have to see the
> value skips there...

Does this help? Log attached. (head -n 100, tail -n 100)

Hardware is  .....

00:1b.0 Audio device: Intel Corporation 82801JI (ICH10 Family) HD Audio 
Controller

module: snd_hda_intel
pcm: AD198x Analog
kernel: kernel-2.6.29-0.43.rc6.fc10.x86_64
alsa: alsa-lib-1.0.19-2.fc10.x86_64 (plus printf patch)

Regards

Clive
-- 
Clive Messer <clive@vacuumtube.org.uk>


--Boundary-00=_drTpJYSj6ki3C6h
Content-Type: text/x-log;
  charset="UTF-8";
  name="hda.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hda.log"

hwsync: 0(0), 0(0)
28238	28236	0	4416	0	4	1	2
hwsync: 0(0), 1(0)
28247	28246	22	4415	0	4	1	2
hwsync: 0(0), 2(0)
28251	28251	45	4414	0	4	1	2
hwsync: 0(0), 3(0)
28253	28253	68	4413	0	4	1	2
hwsync: 0(0), 4(0)
28258	28258	90	4412	0	4	1	2
hwsync: 0(0), 5(0)
28260	28260	113	4411	0	4	1	2
hwsync: 0(0), 6(0)
28262	28262	136	4410	0	4	1	2
hwsync: 0(0), 7(0)
28264	28264	158	4409	0	4	1	2
hwsync: 0(0), 8(0)
28267	28266	181	4408	0	4	1	2
hwsync: 0(0), 9(0)
28269	28268	204	4407	0	4	1	2
hwsync: 0(0), 10(0)
28271	28271	226	4406	0	4	1	2
hwsync: 0(0), 11(0)
28273	28273	249	4405	0	4	1	2
hwsync: 0(0), 12(0)
28275	28275	272	4404	0	4	1	2
hwsync: 0(0), 13(0)
28277	28277	294	4403	0	4	1	2
hwsync: 0(0), 14(0)
28279	28279	317	4402	0	4	1	2
hwsync: 0(0), 15(0)
28281	28281	340	4401	0	4	1	2
hwsync: 0(0), 16(0)
28283	28283	362	4400	0	4	1	2
hwsync: 0(0), 17(0)
28285	28285	385	4399	0	4	1	2
hwsync: 0(0), 18(0)
28287	28287	408	4398	0	4	1	2
hwsync: 0(0), 19(0)
28289	28289	430	4397	0	4	1	2
hwsync: 0(0), 20(0)
28291	28291	453	4396	0	4	1	2
hwsync: 0(0), 21(0)
28293	28293	476	4395	0	4	1	2
hwsync: 0(0), 22(0)
28295	28295	498	4394	0	4	1	2
hwsync: 0(0), 23(0)
28298	28297	521	4393	0	4	1	2
hwsync: 0(0), 24(0)
28300	28299	544	4392	0	4	1	2
hwsync: 0(0), 25(0)
28302	28301	566	4391	0	4	1	2
hwsync: 0(0), 26(0)
28304	28304	589	4390	0	4	1	2
hwsync: 0(0), 27(0)
28306	28306	612	4389	0	4	1	2
hwsync: 0(0), 28(0)
28308	28308	634	4388	0	4	1	2
hwsync: 0(0), 29(0)
28310	28310	657	4387	0	4	1	2
hwsync: 0(0), 30(0)
28312	28312	680	4386	0	4	1	2
hwsync: 0(0), 31(0)
28314	28314	702	4385	0	4	1	2
hwsync: 0(0), 32(0)
28316	28316	725	4384	0	4	1	2
hwsync: 0(0), 33(0)
28318	28318	748	4383	0	4	1	2
hwsync: 0(0), 34(0)
28320	28320	770	4382	0	4	1	2
hwsync: 0(0), 35(0)
28322	28322	793	4381	0	4	1	2
hwsync: 0(0), 36(0)
28324	28324	816	4380	0	4	1	2
hwsync: 0(0), 37(0)
28326	28326	839	4379	0	4	1	2
hwsync: 0(0), 38(0)
28328	28328	861	4378	0	4	1	2
hwsync: 0(0), 39(0)
28331	28330	884	4377	0	4	1	2
hwsync: 0(0), 40(0)
28333	28332	907	4376	0	4	1	2
hwsync: 0(0), 41(0)
28335	28334	929	4375	0	4	1	2
hwsync: 0(0), 42(0)
28337	28337	952	4374	0	4	1	2
hwsync: 0(0), 43(0)
28339	28339	975	4373	0	4	1	2
hwsync: 0(0), 44(0)
28341	28341	997	4372	0	4	1	2
hwsync: 0(0), 45(0)
28343	28343	1020	4371	0	4	1	2
hwsync: 0(0), 46(0)
28345	28345	1043	4370	0	4	1	2
hwsync: 0(0), 47(0)
28347	28347	1065	4369	0	4	1	2
hwsync: 0(0), 48(0)
28349	28349	1088	4368	0	4	1	2
hwsync: 0(0), 49(0)
28351	28351	1111	4367	0	4	1	2
hwsync: 1108800(0), 1113216(0)
25178862	25178861	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178863	25178863	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178865	25178865	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178867	25178867	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178869	25178869	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178870	25178870	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178872	25178872	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178874	25178874	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178876	25178876	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178878	25178877	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178879	25178879	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178881	25178881	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178883	25178883	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178885	25178885	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178887	25178886	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178888	25178888	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178890	25178890	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178892	25178892	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178894	25178894	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178895	25178895	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178897	25178897	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178899	25178899	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178901	25178901	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178903	25178902	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178904	25178904	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178906	25178906	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178908	25178908	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178910	25178910	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178912	25178911	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178913	25178913	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178915	25178915	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178917	25178917	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178919	25178919	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178921	25178920	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178922	25178922	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178924	25178924	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178926	25178926	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178928	25178927	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178929	25178929	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178931	25178931	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178933	25178933	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178935	25178935	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178937	25178936	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178938	25178938	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178940	25178940	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178942	25178942	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178944	25178944	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178946	25178945	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25178947	25178947	25142834	0	4416	0	0	3
hwsync: 1108800(0), 1113216(0)
25693169	25693168	25657142	21697	-18264	0	1	3
alsa-time-test: alsa-time-test.c:189: main: Assertion `(unsigned) avail <= buffer_size' failed.

--Boundary-00=_drTpJYSj6ki3C6h
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_drTpJYSj6ki3C6h--
